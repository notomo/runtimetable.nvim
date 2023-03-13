local M = {}

--- Table to set |'runtimepath'| file or direcotry contents.
--- @class RuntimetableRuntime

--- Returns table to set runtime file content.
--- @param base_path string base runtime directory path
--- @return RuntimetableRuntime # |RuntimetableRuntime|
function M.new(base_path)
  return require("runtimetable.command").new(base_path)
end

--- Save runtime files.
--- @param runtime RuntimetableRuntime |RuntimetableRuntime|
function M.save(runtime)
  require("runtimetable.command").save(runtime)
end

function M._call(base_path, dir_parts)
  require("runtimetable.command").call(base_path, dir_parts)
end

return M
