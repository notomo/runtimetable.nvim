local M = {}
M.__index = M

function M.setup(root_path, opts)
  opts = opts or {}
  local base_dir = opts.base_dir or "test_data/"
  local base_path = vim.fs.joinpath(root_path, base_dir)
  local relative_path = vim.fs.joinpath(base_dir, math.random(1, 2 ^ 30))
  local full_path = vim.fs.joinpath(root_path, relative_path)
  local tbl = {
    full_path = full_path,
    _relative_path = relative_path,
    _base_path = base_path,
  }
  local self = setmetatable(tbl, M)

  self:create_dir("")

  return self
end

function M.create_file(self, path, content)
  self:create_dir(vim.fs.dirname(path))

  local file_path = vim.fs.joinpath(self.full_path, path)
  local f = io.open(file_path, "w")
  if not f then
    error("cannot open: " .. file_path)
  end
  if content then
    f:write(content)
  end
  f:close()

  return file_path
end

function M.create_dir(self, path)
  local dir_path = vim.fs.joinpath(self.full_path, path)
  vim.fn.mkdir(dir_path, "p")
  return dir_path
end

function M.path(self, path)
  return vim.fs.joinpath(self.full_path, path)
end

function M.relative_path(self, path)
  return vim.fs.joinpath(self._relative_path, path)
end

function M.cd(self, path)
  local dir_path = vim.fs.joinpath(self.full_path, path)
  vim.api.nvim_set_current_dir(dir_path)
end

local delete = function(target_path)
  local result = vim.fn.delete(target_path, "rf")
  if result == -1 or result == true then
    error("failed to delete: " .. target_path)
  end
end

function M.delete(self, path)
  local target_path = vim.fs.joinpath(self.full_path, path)
  delete(target_path)
end

function M.teardown(self)
  delete(self._base_path)
end

return M
