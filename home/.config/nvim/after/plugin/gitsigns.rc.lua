local present, gitsigns = pcall(require, "gitsigns")
if (not present) then return end

local wkp, wk = pcall(require, "which-key")

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    opts = {
      mode = "n",
      buffer = bufnr
    }

    wk.register({
      -- Navigation
      ["]c"] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Next hunk", expr=true},
      ["[c"] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", "Previus hunk", expr=true},
      ["<leader>"] = {
        g = {
          name = "gitsigns actions",
          a = { ":Gitsigns stage_hunk<CR>", "Stage hunk", mode="n", mode="v" },
          u = { ":Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
          r = { ":Gitsigns reset_hunk<CR>", "Reset hunk", mode="n", mode="v" },
          A = { ":Gitsigns stage_buffer<CR>", "Stage Buffer" },
          R = { ":Gitsigns reset_buffer<CR>", "Reset Buffer" },
          p = { ":Gitsigns preview_hunk<CR>", "Preview hunk" },
          b = { ":Gitsigns blame_line<CR>", "Blame line" },
          d = { ":Gitsigns diffthis<CR>", "Show diff" },
          D = { ":Gitsigns diffthis '~'<CR>", "Show all diff" },
          t = {
            name = "gitsigns toggle",
            b = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
            d = { ":Gitsigns toggle_deleted<CR>", "Toggle deleted" },
          }
        },
      },
      i = {
        name = "gitsigns text object",
        h = { ":<C-U>GitSigns select_hunk<CR>", "Select hunk", mode="o", mode="x" }
      }
    }, opts)

  end
}
