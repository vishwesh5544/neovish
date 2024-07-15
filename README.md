
# neovish

Welcome to **neovish**, my personalized Neovim configuration. This setup is designed to enhance productivity and streamline the development workflow with Neovim.

## Features

- **Plugin Management**: Easily manage plugins with `lazy.nvim`.
- **LSP Integration**: Out-of-the-box support for LSP configurations for better coding assistance.
- **Autocomplete**: Powerful autocompletion with `nvim-cmp`.
- **File Navigation**: Efficient file navigation using `Telescope`.
- **Syntax Highlighting**: Enhanced syntax highlighting with `nvim-treesitter`.
- **Code Formatting**: Automatic code formatting with `mason-lspconfig`.
- **Clipboard Integration**: Seamless copy-paste functionality with system clipboard.
- **Dark Theme**: Beautiful Catppuccin theme for a visually pleasing experience.
- **AI Assistance**: Integrated GitHub Copilot for AI-powered code suggestions.

## Installation

### Prerequisites

- [Neovim](https://neovim.io/) (version 0.5 or later)
- [Git](https://git-scm.com/)
- A terminal emulator

### Steps

1. **Clone the Repository**

   ```sh
   git clone https://github.com/vishwesh5544/neovish.git ~/.config/nvim
   ```

2. **Install Plugins**

   Open Neovim and install the plugins using `lazy.nvim`:

   ```sh
   nvim +LazySync +qall
   ```

3. **Enjoy your new Neovim setup!**

## Keybindings

### General

- `Space` as the leader key
- `<Leader>pv`: Open Ex mode
- `<C-c>`: Copy in visual mode
- `<C-v>`: Paste in normal and insert modes

### Telescope

- `<Leader>ff`: Find files
- `<Leader>fg`: Live grep
- `<Leader>fb`: List open buffers
- `<Leader>fh`: Help tags

### LSP

- `gD`: Go to declaration
- `gd`: Go to definition
- `K`: Hover documentation
- `gi`: Go to implementation
- `<C-k>`: Signature help
- `<Leader>wa`: Add workspace folder
- `<Leader>wr`: Remove workspace folder
- `<Leader>wl`: List workspace folders
- `<Leader>D`: Type definition
- `<Leader>rn`: Rename
- `gr`: References
- `<Leader>ca`: Code action
- `<Leader>e`: Show diagnostics
- `[d`: Previous diagnostic
- `]d`: Next diagnostic
- `<Leader>q`: Set loclist
- `<Leader>f`: Format

## Configuration Overview

### init.lua

```lua
-- Set mapleader before loading any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("vish.config")
require("vish.remap")


```

### remap.lua

```lua
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


```

### lazy.lua

```lua
-- ~/.config/nvim/lua/vish/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "vish.plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

```

### mason.lua

```lua
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

```

### telescope.lua

```lua
-- Telescope setup
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = require('telescope.actions').move_selection_next,
        ["<C-p>"] = require('telescope.actions').move_selection_previous,
      },
    },
  }
}

```

### treesitter.lua

```lua

-- ~/.config/nvim/lua/vish/config/lazy.lua

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "lua", "python", "typescript", "javascript", "html", "css", "json", "yaml",
    "vimdoc", "luadoc", "vim", "markdown",
  },
  sync_install = false,  -- install languages synchronously (only applied to `ensure_installed`)
  auto_install = true,  -- automatically install missing parsers when entering buffer
  ignore_install = { "phpdoc" },  -- list of parsers to ignore installing (for example)
  highlight = {
    enable = true,  -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}

```

## Contributing

Feel free to fork this repository and make your own changes. Pull requests are welcome!
