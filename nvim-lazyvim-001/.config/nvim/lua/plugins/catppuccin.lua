return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = true,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = {},
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
      },
    },
    custom_highlights = function(colors)
      return {
        WinSeparator = { fg = colors.surface1 },
        Comment = { fg = colors.green },
        Pmenu = { fg = colors.text, bg = colors.base },
        LineNrAbove = { fg = colors.overlay1 },
        LineNr = { fg = colors.overlay1 },
        LineNrBelow = { fg = colors.overlay1 },
        CursorLineNr = { fg = colors.mauve },
      }
    end,
    default_integrations = true,
    integrations = {
      blink_cmp = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      dropbar = {
        enabled = true,
        color_mode = true,
      },
    },
  },
}
