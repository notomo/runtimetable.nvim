local M = {}

--- Table to set |'runtimepath'| file or direcotry contents.
--- @class RuntimetableRuntime
--- @field [string] fun()|RuntimetableRuntime|string

--- Returns table to set runtime file content.
--- @param base_path string base runtime directory path
--- @return RuntimetableRuntime # |RuntimetableRuntime|
function M.new(base_path)
  return require("runtimetable.command").new(base_path)
end

--- @class RuntimetableSaveOption
--- @field as_binary boolean save lua function as binary representation by |string.dump()| if without upvalue (default: false)

--- Save runtime files.
--- @param runtime RuntimetableRuntime |RuntimetableRuntime|
--- @param opts RuntimetableSaveOption? |RuntimetableSaveOption|
function M.save(runtime, opts)
  require("runtimetable.command").save(runtime, opts)
end

function M._call(base_path, dir_parts, path)
  require("runtimetable.command").call(base_path, dir_parts, path)
end

return M
