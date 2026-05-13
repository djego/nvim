vim.g.mapleader = " "
require("keymaps").setup()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Colors / clipboard
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Editing comfort
vim.opt.backspace = "indent,eol,start"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Persistence / responsiveness
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabline siempre visible (necesario para bufferline)
vim.opt.showtabline = 2

vim.cmd([[colorscheme catppuccin]])

-- Diagnostics: virtual text + floats con border
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})

-- Iconos en signs de diagnóstico
local signs = { Error = " ", Warn = " ", Info = " ", Hint = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Border rounded en hover y signature_help
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Cursorline solo en la ventana activa
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function() vim.wo.cursorline = true end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function() vim.wo.cursorline = false end,
})

-- Relativenumber solo en normal mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() vim.wo.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() vim.wo.relativenumber = true end,
})

-- LSP keymaps (only attached to buffers with an active server)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,        opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,       opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  opts)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>d",  vim.diagnostic.open_float, opts)
  end,
})
