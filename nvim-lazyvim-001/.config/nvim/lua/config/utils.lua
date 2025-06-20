local M = {}

local snacks = require("snacks")

--- Toggle "Copy Mode" for Neovim.
--  When enabled, disables line numbers, signcolumn, listchars,
--  and indentation guides for a distraction-free view and useful for
--  copying text). When disabled, restores the previous editor settings.
function toggle_clean_copy(is_copy_mode)
  local vc = require("virt-column")

  -- Determine if clean copy mode should be enabled (line numbers off)
  if is_copy_mode then
    -- Enable clean copy mode: hide UI elements for distraction-free copying
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.signcolumn = "no"
    vim.opt.list = false
    vc.overwrite({char = ""})
    snacks.indent.disable()
  else
    -- Restore normal editor settings
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn = "yes"
    vim.opt.list = true
    vc.overwrite({char = "│"})
    snacks.indent.enable()
  end
end

return M
