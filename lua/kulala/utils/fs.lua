local M = {}

-- find nearest file in parent directories, starting from the current buffer file path
-- @param filename: string
-- @return string|nil
-- @usage local p = fs.find_file_in_parent_dirs('Makefile')
M.find_file_in_parent_dirs = function(filename)
  local dir = vim.fn.expand('%:p:h')
  while dir ~= '/' do
    local parent = dir .. '/' .. filename
    if vim.fn.filereadable(parent) == 1 then
      return parent
    end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return nil
end

-- Get plugin tmp directory
-- @return string
-- @usage local p = fs.get_plugin_tmp_dir()
M.get_plugin_tmp_dir = function()
  local dir = vim.fn.stdpath('data') .. '/tmp/kulala'
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
  return dir
end

-- Check if a command is available
-- @param cmd: string
-- @return boolean
-- @usage local p = fs.command_exists('ls')
M.command_exists = function(cmd)
  return vim.fn.executable(cmd) == 1
end

return M
