return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_better_performance = 0

      vim.g.gruvbox_material_visual = "grey background"
      vim.g.gruvbox_material_menu_selection_background = "orange"
      vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_material_spell_foreground = "none"
      vim.g.gruvbox_material_cursor = "purple"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "material"

      require("lualine").setup({ options = { theme = "gruvbox-material" } })
    end,
    dependencies = {
      "folke/snacks.nvim",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
