local M = {}

function M.executable_string(fn)
  local info = debug.getinfo(fn)
  if info.nups > 0 then
    return nil
  end

  local content
  local path = info.source:sub(2)
  if vim.startswith(info.source, "@") and vim.fn.filereadable(path) == 1 then
    local f = io.open(path, "r")
    content = f:read("*a")
    f:close()
  else
    -- for loadstring
    content = info.source
  end
  local lines = vim.split(content, "\n", { plain = true })

  local first_row = info.linedefined + 1
  local last_row = info.lastlinedefined - 1
  local ranged_lines = vim.list_slice(lines, first_row, last_row)
  return table.concat(ranged_lines, "\n")
end

return M
