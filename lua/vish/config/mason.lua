
-- ~/.config/nvim/lua/vish/config/mason.lua

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "tsserver" },
})

-- Setup neodev before lspconfig
require('neodev').setup({})

-- Setup language servers using lspconfig
local lspconfig = require("lspconfig")

-- Create an augroup for LSP formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Common on_attach function for LSP servers
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- Prevent prompting for unnecessary third-party libraries
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  settings = {
    python = {
      formatting = {
        provider = "black",
      },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  settings = {
    documentFormatting = false,  -- Let prettier handle formatting if needed
  },
  commands = {
    Format = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
    },
  },
}
