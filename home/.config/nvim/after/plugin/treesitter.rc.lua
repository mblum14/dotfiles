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
    "hcl",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "latex",
    "lua",
    "make",
    "perl",
    "python",
    "regex",
    "ruby",
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

local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
parser_configs.tsx.used_by = { "javascript", "typescript.tsx" }
