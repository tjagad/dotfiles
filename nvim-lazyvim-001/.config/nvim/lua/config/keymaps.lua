-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Snacks = require("snacks")

Snacks.toggle({
  name = "Copy Mode",
  get = function()
    return not vim.opt.number:get()
  end,
  set = function(state)
    toggle_clean_copy(state)
  end,
}):map("<leader>uu")

Snacks.toggle({
  name = "Show keys",
  get = function()
    return vim.g.showkeys_status
  end,
  set = function(state)
    vim.g.showkeys_status = state
    require("showkeys").toggle()
  end,
}):map("<leader>uk")

Snacks.toggle({
  name = "Hardtime",
  get = function()
    return not vim.g.hardtime_status
  end,
  set = function(state)
    vim.g.hardtime_status = not state
    vim.cmd("Hardtime toggle")
  end,
}):map("<leader>uH")

vim.keymap.set(
  "n",
  "<leader>om",
  function()
    vim.ui.input({ prompt = "Set move_count: ",
      default = tostring(vim.g.move_count or 3) },
      function(input)
        if input then
          vim.g.move_count = tonumber(input) or vim.g.move_count
          update_move_count_keymaps(vim.g.move_count)
        end
      end)
  end,
  { desc = "Set move_count" }
)

vim.keymap.set(
  {"n", "v"},
  "_Y",
  function ()
    vim.cmd("w! ~/.vi_tmp")
    vim.notify("Wrote to ~/.vi_tmp", vim.log.levels.INFO)
  end,
  {desc = "Write buffer or selection to ~/.vi_tmp"}
)

vim.keymap.set(
  {"n"},
  "_P",
  function ()
    vim.cmd("r ~/.vi_tmp")
    vim.notify("Read from ~/.vi_tmp", vim.log.levels.INFO)
  end,
  {desc = "Read from ~/.vi_tmp"}
)
