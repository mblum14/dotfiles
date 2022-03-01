local M = {}
local cmd = vim.cmd
local colors = {
  white = "#c7b89c",
  darker_black = "#1e2122",
  black = "#222526", -- nvim bg
  black2 = "#26292a",
  one_bg = "#2b2e2f",
  one_bg2 = "#2f3233",
  one_bg3 = "#313435",
  grey = "#46494a",
  grey_fg = "#5d6061",
  grey_fg2 = "#5b5e5f",
  light_grey = "#585b5c",
  red = "#ec6b64",
  baby_pink = "#ce8196",
  pink = "#ff75a0",
  line = "#2c2f30", -- for lines like vertsplit
  green = "#89b482",
  vibrant_green = "#a9b665",
  nord_blue = "#6f8faf",
  blue = "#6d8dad",
  yellow = "#d6b676",
  sun = "#d1b171",
  purple = "#b4bbc8",
  dark_purple = "#cc7f94",
  teal = "#7f9689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#252829",
  lightbg = "#2d3139",
  lightbg2 = "#262a32",
  pmenu_bg = "#89b482",
  folder_bg = "#6d8dad",
  base00 = "282828",
  base01 = "3c3836",
  base02 = "504945",
  base03 = "665c54",
  base04 = "bdae93",
  base05 = "d5c4a1",
  base06 = "ebdbb2",
  base07 = "fbf1c7",
  base08 = "fb4934",
  base09 = "fe8019",
  base0A = "fabd2f",
  base0B = "b8bb26",
  base0C = "8ec07c",
  base0D = "83a598",
  base0E = "d3869b",
  base0F = "d65d0e",
}

M.init = function()
  local black = colors.black
  local black2 = colors.black2
  local blue = colors.blue
  local darker_black = colors.darker_black
  local folder_bg = colors.folder_bg
  local green = colors.green
  local grey = colors.grey
  local grey_fg = colors.grey_fg
  local light_grey = colors.light_grey
  local line = colors.line
  local nord_blue = colors.nord_blue
  local one_bg = colors.one_bg
  local one_bg2 = colors.one_bg2
  local pmenu_bg = colors.pmenu_bg
  local purple = colors.purple
  local red = colors.red
  local white = colors.white
  local yellow = colors.yellow
  local orange = colors.orange
  local one_bg3 = colors.one_bg3
  
  -- functions for setting highlights
  local fg = function(group, col)
     cmd("hi " .. group .. " guifg=" .. col)
  end
  local fg_bg = function(group, fgcol, bgcol)
     cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
  end
  local bg = function(group, col)
     cmd("hi " .. group .. " guibg=" .. col)
  end
  
  -- Comments
  fg("Comment", grey_fg)
  
  -- Disable cursor line
  cmd "hi clear CursorLine"
  -- Line number
  fg("cursorlinenr", white)
  
  -- same it bg, so it doesn't appear
  fg("EndOfBuffer", black)
  
  -- For floating windows
  fg("FloatBorder", blue)
  bg("NormalFloat", darker_black)
  
  -- Pmenu
  bg("Pmenu", one_bg)
  bg("PmenuSbar", one_bg2)
  bg("PmenuSel", pmenu_bg)
  bg("PmenuThumb", nord_blue)
  fg("CmpItemAbbr", white)
  fg("CmpItemAbbrMatch", white)
  fg("CmpItemKind", white)
  fg("CmpItemMenu", white)
  
  -- misc
  
  -- inactive statuslines as thin lines
  fg("StatusLineNC", one_bg3 .. " gui=underline")
  
  fg("LineNr", grey)
  fg("NvimInternalError", red)
  fg("VertSplit", one_bg2)
  
  -- transparency
  bg("Normal", "NONE")
  bg("Folded", "NONE")
  fg("Folded", "NONE")
  fg("Comment", grey)
  -- telescope
  bg("TelescopeBorder", "NONE")
  bg("TelescopePrompt", "NONE")
  bg("TelescopeResults", "NONE")
  bg("TelescopePromptBorder", "NONE")
  bg("TelescopePromptNormal", "NONE")
  bg("TelescopeNormal", "NONE")
  bg("TelescopePromptPrefix", "NONE")
  fg("TelescopeBorder", one_bg)
  fg_bg("TelescopeResultsTitle", black, blue)
  
  -- [[ Plugin Highlights
  
  -- Dashboard
  fg("AlphaHeader", grey_fg)
  fg("AlphaButtons", light_grey)
  
  -- Git signs
  fg_bg("DiffAdd", blue, "NONE")
  fg_bg("DiffChange", grey_fg, "NONE")
  fg_bg("DiffChangeDelete", red, "NONE")
  fg_bg("DiffModified", red, "NONE")
  fg_bg("DiffDelete", red, "NONE")
  
  -- Indent blankline plugin
  fg("IndentBlanklineChar", line)
  fg("IndentBlanklineSpaceChar", line)
  
  -- Lsp diagnostics
  
  fg("DiagnosticHint", purple)
  fg("DiagnosticError", red)
  fg("DiagnosticWarn", yellow)
  fg("DiagnosticInformation", green)
  
  -- Telescope
  fg_bg("TelescopeBorder", darker_black, darker_black)
  fg_bg("TelescopePromptBorder", black2, black2)
  
  fg_bg("TelescopePromptNormal", white, black2)
  fg_bg("TelescopePromptPrefix", red, black2)
  
  bg("TelescopeNormal", darker_black)
  
  fg_bg("TelescopePreviewTitle", black, green)
  fg_bg("TelescopePromptTitle", black, red)
  fg_bg("TelescopeResultsTitle", darker_black, darker_black)
  
  bg("TelescopeSelection", black2)
  
  local section_title_colors = {
     white,
     blue,
     red,
     green,
     yellow,
     purple,
     orange,
  }
  for i, color in ipairs(section_title_colors) do
     vim.cmd("highlight CheatsheetTitle" .. i .. " guibg = " .. color .. " guifg=" .. black)
  end
end
M.get = function()
  return colors
end
return M
