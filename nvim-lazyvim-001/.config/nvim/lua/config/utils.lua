--- Toggle "Clean Copy Mode" for Neovim.
--  When enabled, disables line numbers, signcolumn, listchars, cursorcolumn,
--  and indentation guides for a distraction-free view (useful for copying text).
--  When disabled, restores the previous editor settings.
function toggle_clean_copy()
  -- Determine if clean copy mode should be enabled (line numbers off)
---@diagnostic disable-next-line: undefined-field
  local is_clean = not vim.opt.number:get()
  if not is_clean then
    -- Enable clean copy mode: hide UI elements for distraction-free copying
    vim.opt.number = false
    vim.opt.signcolumn = "no"
    vim.opt.list = false
    vim.opt.cursorcolumn = false
    require("virt-column").overwrite({char = ""})
    Snacks.indent.disable()
    vim.notify(" Clean Copy Mode")
  else
    -- Restore normal editor settings
    vim.opt.number = true
    vim.opt.signcolumn = "yes"
    vim.opt.list = true
    vim.opt.cursorcolumn = true
    require("virt-column").overwrite({char = "│"})
    Snacks.indent.enable()
    vim.notify(" Clean Copy Mode")
  end
end

return {}
