local helper = require("runtimetable.test.helper")
local runtimetable = helper.require("runtimetable")

describe("runtimetable", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("can create runtime files with non-upvalue", function()
    local dir_path = helper.test_data:create_dir("dir")
    vim.opt.runtimepath:prepend(dir_path)

    local runtime = runtimetable.new(dir_path)

    runtime.lua.runtimetable_test["target.lua"] = function()
      vim.b.called = true
    end

    runtimetable.save(runtime)
    vim.cmd.runtime("lua/runtimetable_test/target.lua")

    assert.is_true(vim.b.called)
  end)

  it("can create runtime files with upvalue", function()
    local dir_path = helper.test_data:create_dir("dir")
    vim.opt.runtimepath:prepend(dir_path)

    local runtime = runtimetable.new(dir_path)

    local called = false
    runtime.lua.runtimetable_test["target.lua"] = function()
      called = true
    end

    runtimetable.save(runtime)
    vim.cmd.runtime("lua/runtimetable_test/target.lua")

    assert.is_true(called)
  end)

  it("can create runtime files with string", function()
    local dir_path = helper.test_data:create_dir("dir")
    vim.opt.runtimepath:prepend(dir_path)

    local runtime = runtimetable.new(dir_path)

    runtime.lua.runtimetable_test["target.lua"] = [[
vim.b.called = true
]]

    runtimetable.save(runtime)
    vim.cmd.runtime("lua/runtimetable_test/target.lua")

    assert.is_true(vim.b.called)
  end)

  it("shows a warning if runtimetable is already uninstalled", function()
    local dir_path = helper.test_data:create_dir("dir")
    vim.opt.runtimepath:prepend(dir_path)

    local runtime = runtimetable.new(dir_path)

    local dummy = false
    runtime.lua.runtimetable_test["target.lua"] = function()
      dummy = true
    end
    local _ = dummy

    runtimetable.save(runtime)

    vim.opt.runtimepath:remove(helper.root)
    package.loaded["runtimetable"] = nil

    vim.cmd.runtime("lua/runtimetable_test/target.lua")

    assert.exists_message([[not installed runtimetable: ]])
  end)
end)
