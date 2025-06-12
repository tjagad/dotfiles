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
    vim.opt.signcolumn = "no"
    vim.opt.list = false
    vc.overwrite({char = ""})
    snacks.indent.disable()
  else
    -- Restore normal editor settings
    vim.opt.number = true
    vim.opt.signcolumn = "yes"
    vim.opt.list = true
    vc.overwrite({char = "│"})
    snacks.indent.enable()
  end
end

snacks.toggle({
  name = "Copy Mode",
  get = function()
    return not vim.opt.number:get()
  end,
  set = function(state)
    toggle_clean_copy(state)
  end,
}):map("<leader>uu")

snacks.toggle({
  name = "Show keys",
  get = function()
    return vim.g.showkeys_status
  end,
  set = function(state)
    vim.g.showkeys_status = state
    require("showkeys").toggle()
  end,
}):map("<leader>uk")

return M
