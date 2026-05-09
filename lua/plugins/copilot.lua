return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
    -- <C-j> para aceptar (evita choque con <C-l> de navegación de splits)
    vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")',
      { silent = true, expr = true })
  end,
}
