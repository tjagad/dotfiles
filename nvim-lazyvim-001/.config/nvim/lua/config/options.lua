-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- show sign column
vim.opt.signcolumn = "yes"

-- set colorcolumn to 80 characters
vim.opt.colorcolumn = "80"

-- turn off autoformatting
vim.g.autoformat = false

-- turn off lsp logging by default
vim.lsp.set_log_level("off")
