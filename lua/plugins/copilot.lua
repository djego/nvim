return {
  "github/copilot.vim",
  config = function()
    -- Opcional: deshabilitar tab y usar <C-l> para aceptar sugerencias
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")',
      { silent = true, expr = true })
  end
}

