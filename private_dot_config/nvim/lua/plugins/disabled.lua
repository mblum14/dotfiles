return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "folke/tokynonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    -- Currently causes neovim to crash
    "folke/noice.nvim",
    enabled = true,
  },
  {
    -- Need to enable but disable highlights since they currently cause
    -- neovim to crash
    "nvim-treesitter/nvim-treesitter",
     enabled = true
     --opts = { highlight = { enable = false } }
  },
}
