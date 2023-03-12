local M = {}

local _runtimes = {}

function M.new(base_path)
  local runtime = require("runtimetable.runtime").new()
  _runtimes[base_path] = runtime
  return runtime
end

function M.save(runtime)
  local target_path
  for path, r in pairs(_runtimes) do
    if runtime == r then
      target_path = path
      break
    end
  end

  if not target_path then
    error("not found runtime")
  end

  require("runtimetable.runtime").save(target_path, runtime)
end

function M.call(base_path, dir_parts)
  local runtime = _runtimes[base_path]
  if not runtime then
    error("not found runtime for: " .. base_path)
  end

  local f = vim.tbl_get(runtime, unpack(dir_parts))
  if type(f) ~= "function" then
    error("unexpected runtime type: " .. type(f))
  end

  f()
end

return M
