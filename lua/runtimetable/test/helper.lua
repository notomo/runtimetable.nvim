local helper = require("vusted.helper")
local plugin_name = helper.get_module_root(...)

helper.root = helper.find_plugin_root(plugin_name)
helper.runtimepath = vim.o.runtimepath

function helper.before_each()
  vim.o.runtimepath = helper.runtimepath
  helper.test_data = require("runtimetable.vendor.misclib.test.data_dir").setup(helper.root)
end

function helper.after_each()
  helper.cleanup()
  helper.cleanup_loaded_modules(plugin_name)
  helper.test_data:teardown()
end

local asserts = require("vusted.assert").asserts
local asserters = require(plugin_name .. ".vendor.assertlib").list()
require(plugin_name .. ".vendor.misclib.test.assert").register(asserts.create, asserters)

return helper
