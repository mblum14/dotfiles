return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        helm_ls = {},
      },
    },
  },
  {
    name = "amazonq",
    url = "https://github.com/awslabs/amazonq.nvim.git",
    dependencies = {
      "nvim-cmp",
    },
    keys = {
      {
        "<leader>aqa",
        "<cmd>AmazonQ<cr>",
        desc = "Toggle (AmazonQ)",
        mode = { "n", "v" },
      },
      {
        "<leader>aqf",
        "<cmd>.AmazonQ fix<cr>",
        desc = "Fix current line (AmazonQ)",
        mode = { "n", "v" },
      },
      {
        "<leader>aqr",
        "<cmd>AmazonQ refactor<cr>",
        desc = "Refactor selected code(AmazonQ)",
        mode = { "n", "v" },
      },
      {
        "<leader>aqo",
        "<cmd>%AmazonQ optimize<cr>",
        desc = "Optimize current file(AmazonQ)",
        mode = { "n", "v" },
      },
      {
        "<leader>aqe",
        "<cmd>%AmazonQ explain<cr>",
        desc = "Explain current file(AmazonQ)",
        mode = { "n", "v" },
      },
    },
    opts = function()
      require("amazonq").setup({
        ssoStartUrl = "https://bti360.awsapps.com/start",
        inline_suggest = true,
        debug = false,
      })
    end,
  },
}
