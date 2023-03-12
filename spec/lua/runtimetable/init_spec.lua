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
end)
