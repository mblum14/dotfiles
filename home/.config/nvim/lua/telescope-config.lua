local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

M.git_or_find_files = function()
  local opts = {
    cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  }
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

M.live_grep_from_root = function()
  local opts = {
    cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  }
  require"telescope.builtin".live_grep(opts)
end

return M
