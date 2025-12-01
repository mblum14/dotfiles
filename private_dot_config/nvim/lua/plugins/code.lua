return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "default" },
    },
  },
  {
    "StackInTheWild/headhunter.nvim",
    config = function()
      require("headhunter").setup({
        enabled = true,
        keys = {
          prev = "[g",
          next = "]g",
          take_head = "<leader>gh",
          take_origin = "<leader>go",
          take_both = "<leader>gb",
          quickfix = "<leader>gq",
        },
      })
    end,
  },
}
