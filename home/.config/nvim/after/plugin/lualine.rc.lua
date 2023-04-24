local present, lualine = pcall(require, "lualine")
if (not present) then return end

local hasgps, gps = pcall(require, "nvim-gps")

local icons = require("config/icons")

local function separator()
  return "%="
end

local function lsp_client(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- add formatter
  local formatters = require "config.lsp.null-ls.formatters"
  local supported_formatters = formatters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_formatters)

  -- add linter
  local linters = require "config.lsp.null-ls.linters"
  local supported_linters = linters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)

  -- add hover
  local hovers = require "config.lsp.null-ls.hovers"
  local supported_hovers = hovers.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_hovers)

  -- add code action
  local code_actions = require "config.lsp.null-ls.code_actions"
  local supported_code_actions = code_actions.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_code_actions)

  local hash = {}
  local client_names = {}
  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      client_names[#client_names + 1] = v
      hash[v] = true
    end
  end
  table.sort(client_names)
  return "[" .. table.concat(client_names, ", ") .. "]"
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {
        "help",
        "NvimTree",
        "terminal",
        "alpha"
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
          hint = icons.diagnostics.Hint,
        },
        colored = false,
      },
    },
    lualine_c = {
      { separator },
      { lsp_client, icon = " " },
      -- { lsp_progress },
      {
          gps.get_location,
          cond = gps.is_available,
      },
    },
    lualine_x = {'filename', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {
    "quickfix",
    "fzf",
    "trouble"
  }
}
