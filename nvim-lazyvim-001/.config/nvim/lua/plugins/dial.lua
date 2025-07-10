return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-b>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "g<C-b>", function() return require("dial.map").inc_gnormal() end, expr = true, desc = "Increment", mode = {"n", "v"} },
  },
}
