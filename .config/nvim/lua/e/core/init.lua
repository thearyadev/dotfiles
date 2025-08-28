vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.wo.relativenumber = true

vim.o.clipboard = "unnamedplus"
vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 1},
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true
})
