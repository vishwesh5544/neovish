-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "tsserver" },
})


-- Setup neodev before lspconfig
require('neodev').setup({})


-- Setup language servers using lspconfig
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup {
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

lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
