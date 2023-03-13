local M = {}

local function _walk(tbl, parent_keys, fn)
  for key, value in pairs(tbl) do
    local keys = vim.deepcopy(parent_keys)
    table.insert(keys, key)

    if type(value) == "table" then
      _walk(value, keys, fn)
    else
      fn(value, keys)
    end
  end
end

function M.walk(tbl, fn)
  _walk(tbl, {}, fn)
end

return M
