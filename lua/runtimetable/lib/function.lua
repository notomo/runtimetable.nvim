local M = {}

local remove_indent = function(lines)
  local indent = ""
  for _, line in ipairs(lines) do
    if line ~= "" then
      indent = line:match("^%s*")
      break
    end
  end
  if indent == "" then
    return lines
  end

  return vim
    .iter(lines)
    :map(function(line)
      line = line:gsub("^" .. indent, "")
      return line
    end)
    :totable()
end

function M.executable_string(fn, as_binary)
  local info = debug.getinfo(fn)
  if info.nups > 0 then
    return nil
  end

  if as_binary then
    return string.dump(fn)
  end

  local content
  local path = info.source:sub(2)
  if vim.startswith(info.source, "@") and vim.fn.filereadable(path) == 1 then
    local f = io.open(path, "r")
    if not f then
      error("[runtimetable] can't read path: " .. path)
    end
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
  return table.concat(remove_indent(ranged_lines), "\n")
end

return M
