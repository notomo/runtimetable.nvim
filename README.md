# runtimetable.nvim

Create runtime files from lua table.

## Example

```lua
local path = vim.fn.stdpath("data") .. "/runtimetable"
vim.api.nvim_set_option_value("runtimepath", path, { operation = "prepend" })
vim.api.nvim_set_option_value("runtimepath", path .. "/after", { operation = "append" })

local runtime = require("runtimetable").new(path)

runtime.syntax["test.lua"] = function()
  if vim.b.current_syntax then
    return
  end

  vim.cmd.syntax({ args = { "match", "Comment", [["^\s*#.*"]] } })

  vim.b.current_syntax = "test"
end

runtime.after.ftplugin["test.lua"] = function()
  vim.bo.commentstring = "#%s"
end

runtime.doc["test.txt"] = [[
*test.txt*

============================================================================
]]

require("runtimetable").save(runtime, { as_binary = true })

-- Created the following files:
--  - {path}/syntax/test.lua
--  - {path}/after/ftplugin/test.lua
--  - {path}/doc/test.txt
```