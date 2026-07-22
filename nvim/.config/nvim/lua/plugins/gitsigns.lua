return {
  "lewis6991/gitsigns.nvim",
  -- opts merges with LazyVim's gitsigns opts (no config override).
  opts = {
    current_line_blame = true,
    current_line_blame_opts = { delay = 0 },
  },
  init = function()
    -- Keep the inline blame readable over the cursorline; re-apply on
    -- colorscheme changes since those reset highlight groups.
    local function set_blame_hl()
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#ffcc66" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("blame_readable", { clear = true }),
      callback = set_blame_hl,
    })
    set_blame_hl()
  end,
}
