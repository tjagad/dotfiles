local M = {}

--- globals
vim.g.move_count = vim.g.move_count or 3

--- local variables
local snacks = require("snacks")
local wk = require("which-key")

--- which-key extension
wk.add({
  {"<leader>o", group="options", icon = { icon = "", color = "green" } }
})

-- Updates keymaps for Alt+h/j/k/l to move by a specified count in normal mode
function update_move_count_keymaps(count)
      vim.keymap.set("n", "<C-A-h>", count .. "h",
        { desc = "Navigate left by " .. count .. " characters" })
      vim.keymap.set("n", "<C-A-j>", count .. "j",
        { desc = "Navigate down by " .. count .. " lines" })
      vim.keymap.set("n", "<C-A-k>", count .. "k",
        { desc = "Navigate up by " .. count .. " lines" })
      vim.keymap.set("n", "<C-A-l>", count .. "l",
        { desc = "Navigate right by " .. count .. " characters" })
end
update_move_count_keymaps(vim.g.move_count)

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
