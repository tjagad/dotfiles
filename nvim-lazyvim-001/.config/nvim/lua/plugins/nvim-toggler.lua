return {
  "nguyenvukhang/nvim-toggler",
  config = function()
    require("nvim-toggler").setup({
      -- Add your custom toggles here
      toggles = {
        ["open"] = "close",
        ["start"] = "stop",
        ["show"] = "hide",
        ["add"] = "remove",
      },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
      -- removes the default set of inverses
      remove_default_inverses = false,
      -- auto-selects the longest match when there are multiple matches
      autoselect_longest_match = false
    })
  end,
  keys = {
    {
      "<leader>ct",
      function() require("nvim-toggler").toggle() end,
      mode = { "n", "v" },
      desc = "Toggle word under cursor",
    },
  },
}
