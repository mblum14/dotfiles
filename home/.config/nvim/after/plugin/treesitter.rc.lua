local present, treesitter = pcall(require, "nvim-treesitter.configs")
if (not present) then return end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "clojure",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "elixir",
    "erlang",
    "fish",
    "go",
    "graphql",
    "haskell",
    "hcl",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "latex",
    "lua",
    "make",
    "markdown",
    "perl",
    "python",
    "regex",
    "ruby",
    "rust",
    "scala",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true,
    disable = { },
  }
}

local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.tsx = { "javascript", "typescript.tsx" }
