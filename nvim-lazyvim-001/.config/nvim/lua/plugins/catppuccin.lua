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
            WinSeparator = { fg = colors.surface1 },
            -- use soft green, no italics for comments
            Comment = { fg = colors.green, style = {} },
            -- override default Pmenu colors to match overrides above
            Pmenu = { fg = colors.text, bg = colors.base },
            -- use brighter colors for relative numbers in the signcolumn
            LineNrAbove = { fg = colors.overlay1 },
            LineNr = { fg = colors.overlay1 },
            LineNrBelow = { fg = colors.overlay1 },
            -- use brighter colors for line numbers in the signcolumn
            CursorLineNr = { fg = colors.mauve },
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
