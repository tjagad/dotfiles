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
  pattern = { "c", "cpp", "h", "make", "S", "sh" },
  callback = function()
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
  end,
})

vim.filetype.add({
  extension = {
    h = "c", -- Treat .h files as C files
  },
})

vim.filetype.add({
  extension = {
    S = "asm", -- Treat .S files as assembly
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/home/tjagad/projects/repos/linux/**/*",
  command = "set tags=/home/tjagad/projects/repos/linux/_output/tags",
})
