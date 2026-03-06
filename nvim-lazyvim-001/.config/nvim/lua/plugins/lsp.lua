return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    diagnostics = {
      virtual_text = {
        current_line = true,
      },
    },
    -- Add your servers here
    servers = {
      asmlsp = {
        cmd = { "asm-lsp" },
        filetypes = { "asm", "s", ".S" }, -- ensure .S files are recognized
        root_dir = require("lspconfig").util.root_pattern(".asm-lsp.toml"),
      },
    },
  },
}
