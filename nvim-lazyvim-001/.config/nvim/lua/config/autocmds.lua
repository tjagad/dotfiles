-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Set tab and other settings for Linux kernel and C projects
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "make", "S" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.tabstop = 8
    vim.bo.cindent = true
    vim.bo.autoindent = true
    vim.bo.textwidth = 80
    vim.wo.wrap = false
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
  end,
})
