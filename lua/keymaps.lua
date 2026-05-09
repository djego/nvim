-- lua/keymaps.lua
local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.setup()
  -- Guardar
  M.map("n", "<leader>s", ":w<CR>")
  -- Salir
  M.map("n", "<leader>q", ":q<CR>")
  -- Limpiar búsqueda
  M.map("n", "<leader>h", ":nohlsearch<CR>")

  -- Formatear con LSP
  M.map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format code" })

  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    M.map("n", "gd", builtin.lsp_definitions, { desc = "Ir a definición" })
    M.map("n", "gi", builtin.lsp_implementations, { desc = "Ir a implementación" })
    M.map("n", "gr", builtin.lsp_references, { desc = "Ver referencias" })
    end
 end

return M
