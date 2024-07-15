local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

---------------------------------------
----- CLIPBOARD REMAP STARTS ----------
vim.opt.clipboard:append('unnamedplus')

-- Map Ctrl+C to copy in visual mode
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- Map Ctrl+V to paste in normal and insert mode
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

----- CLIPBOARD REMAP ENDS -----------
--------------------------------------


-- Keybindings for Telescope
map('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', default_opts)
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', default_opts)
map('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', default_opts)
map('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', default_opts)

-- Additional keybindings
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, default_opts)

-- LSP Keymaps
local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end

 -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- LSP mappings
  buf_map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_map('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  buf_map('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  buf_map('n', '<Leader>wl', '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>')
  buf_map('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_map('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  buf_map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  buf_map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  buf_map('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  buf_map('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

-- Setup LSP servers with `on_attach` function
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
}

-- Indentation settings
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 4         -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4            -- Number of spaces that a <Tab> in the file counts for
vim.opt.smartindent = true     -- Make indenting smart
vim.opt.autoindent = true      -- Copy indent from current line when starting a new line

-- Line numbers
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false  -- Show relative line numbers


-- Copilot keybindings
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
