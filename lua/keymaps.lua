-- lua/keymaps.lua
local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.setup()
  -- Archivo
  M.map("n", "<leader>s", ":w<CR>")
  M.map("n", "<leader>q", ":q<CR>")
  M.map("n", "<leader>h", ":nohlsearch<CR>")

  -- Salir de insert sin Esc
  M.map("i", "jk", "<Esc>")

  -- Format con LSP
  M.map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format code" })

  -- Crear / cerrar splits
  M.map("n", "<leader>v", ":vsplit<CR>", { desc = "Split vertical" })
  M.map("n", "<leader>x", ":split<CR>",  { desc = "Split horizontal" })
  M.map("n", "<leader>c", ":close<CR>",  { desc = "Cerrar split actual" })

  -- Navegación entre splits
  M.map("n", "<C-h>", "<C-w>h")
  M.map("n", "<C-j>", "<C-w>j")
  M.map("n", "<C-k>", "<C-w>k")
  M.map("n", "<C-l>", "<C-w>l")

  -- Buffers
  M.map("n", "<S-l>", ":bnext<CR>")
  M.map("n", "<S-h>", ":bprevious<CR>")
  M.map("n", "<leader>bd", ":bdelete<CR>")

  -- Mover líneas en visual
  M.map("v", "J", ":m '>+1<CR>gv=gv")
  M.map("v", "K", ":m '<-2<CR>gv=gv")

  -- Mantener selección al indentar
  M.map("v", "<", "<gv")
  M.map("v", ">", ">gv")

  -- Pegar sin sobrescribir el registro
  M.map("v", "p", '"_dP')

  -- Centrar al hacer scroll / buscar
  M.map("n", "<C-d>", "<C-d>zz")
  M.map("n", "<C-u>", "<C-u>zz")
  M.map("n", "n", "nzzzv")
  M.map("n", "N", "Nzzzv")

  -- Seleccionar todo
  M.map("n", "<leader>a", "ggVG")
end

return M
