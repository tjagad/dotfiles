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
