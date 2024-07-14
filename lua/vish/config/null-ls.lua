-- Null-ls setup
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,  -- JS, TS, JSON, etc.
    null_ls.builtins.formatting.stylua,    -- Lua
    null_ls.builtins.formatting.black,     -- Python
    -- Add more formatters as needed
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.document_formatting then
      vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
