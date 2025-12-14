return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true
    },
    panel = {
      enabled = true
    },
    filetypes = {
      yaml = true,
      markdown = true,
      help = true,
      gitcommit = true,
      gitrebase = true,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = true,
    },
  },
}
