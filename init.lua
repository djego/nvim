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

-- Set line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Set tab and indent settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enable terminal colors
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Allow backspace on indent, EOL, or insert start position
vim.opt.backspace = "indent,eol,start"


vim.cmd([[colorscheme catppuccin]])
