local present, bufferline = pcall(require, "bufferline")

if (not present) then return end

local default = {
   colors = require("colors").get(),
}

default = {
   options = {
      mode = "buffers",
      numbers = "buffer_id",
      diagnostics = "nvim_lsp",
      separator_style = "slant" or "padded_slant",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,

      modified_icon = "",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,

      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            end
            return true
         end

         return true
      end,
   },

   --highlights = {
   --   background = {
   --      guifg = default.colors.grey_fg,
   --      guibg = default.colors.black2,
   --   },

   --   -- buffers
   --   buffer_selected = {
   --      guifg = default.colors.white,
   --      guibg = default.colors.black,
   --      gui = "bold",
   --   },
   --   buffer_visible = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.black2,
   --   },

   --   -- for diagnostics = "nvim_lsp"
   --   error = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.black2,
   --   },
   --   error_diagnostic = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.black2,
   --   },

   --   -- close buttons
   --   close_button = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.black2,
   --   },
   --   close_button_visible = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.black2,
   --   },
   --   close_button_selected = {
   --      guifg = default.colors.red,
   --      guibg = default.colors.black,
   --   },
   --   fill = {
   --      guifg = default.colors.grey_fg,
   --      guibg = default.colors.black2,
   --   },
   --   indicator_selected = {
   --      guifg = default.colors.black,
   --      guibg = default.colors.black,
   --   },

   --   -- modified
   --   modified = {
   --      guifg = default.colors.red,
   --      guibg = default.colors.black2,
   --   },
   --   modified_visible = {
   --      guifg = default.colors.red,
   --      guibg = default.colors.black2,
   --   },
   --   modified_selected = {
   --      guifg = default.colors.green,
   --      guibg = default.colors.black,
   --   },

   --   -- separators
   --   separator = {
   --      guifg = default.colors.black2,
   --      guibg = default.colors.black2,
   --   },
   --   separator_visible = {
   --      guifg = default.colors.black2,
   --      guibg = default.colors.black2,
   --   },
   --   separator_selected = {
   --      guifg = default.colors.black2,
   --      guibg = default.colors.black2,
   --   },

   --   -- tabs
   --   tab = {
   --      guifg = default.colors.light_grey,
   --      guibg = default.colors.one_bg3,
   --   },
   --   tab_selected = {
   --      guifg = default.colors.black2,
   --      guibg = default.colors.nord_blue,
   --   },
   --   tab_close = {
   --      guifg = default.colors.red,
   --      guibg = default.colors.black,
   --   },
   --},
}

bufferline.setup(default)
