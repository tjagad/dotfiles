return {
  "cappyzawa/trim.nvim",
  config = function()
    require("trim").setup({
      ft_blocklist = {
        -- "markdown",
      },

      -- if you want to remove multiple blank lines
      -- patterns = {
      --   [[%s/\(\n\n\)\n\+/\1/]],
      -- },

      -- if you want to disable trim on write by default
      trim_on_write = true,

      -- highlight trailing spaces
      highlight = false,
    })
  end,
}
