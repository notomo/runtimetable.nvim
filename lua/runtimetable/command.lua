local M = {}

local _runtimes = {}

function M.new(base_path)
  local runtime = require("runtimetable.runtime").new()
  _runtimes[base_path] = runtime
  return runtime
end

function M.save(runtime)
  local base_path = require("runtimetable.lib.table").find_key_by_value(_runtimes, runtime)
  if not base_path then
    error("not found runtime")
  end
  require("runtimetable.runtime").save(base_path, runtime)
end

function M.call(base_path, dir_parts)
  local keys = { base_path, unpack(dir_parts) }
  local fn = vim.tbl_get(_runtimes, unpack(keys))
  if type(fn) ~= "function" then
    error("unexpected runtime type: " .. type(fn))
  end
  fn()
end

return M
