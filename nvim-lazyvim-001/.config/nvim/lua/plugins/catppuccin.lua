  return {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      no_italic = true,
      highlight_overrides = {
        mocha = function(colors)
          return {
            WinSeparator = { fg = "#45475a" },
            -- use soft green, no italics for comments
            Comment = { fg = "#a6e3a1", style = {} },
            -- override default Pmenu colors to match overrides above
            Pmenu = { fg=colors.text, bg=colors.base },
          }
        end,
      },
      integrations = {
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        blink_cmp = {
          enabled = true,
          style = 'bordered',
        },
      },
    },
  }
