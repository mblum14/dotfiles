local present, telescope = pcall(require, "telescope")
if (not present) then return end

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      }
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--hidden",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  }
}

telescope.load_extension("fzf")
