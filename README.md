
# neovish

Welcome to **neovish**, my personalized Neovim configuration. This setup is designed to enhance productivity and streamline the development workflow with Neovim.

## Features

- **Plugin Management**: Easily manage plugins with `lazy.nvim`.
- **LSP Integration**: Out-of-the-box support for LSP configurations for better coding assistance.
- **Autocomplete**: Powerful autocompletion with `nvim-cmp`.
- **File Navigation**: Efficient file navigation using `Telescope`.
- **Syntax Highlighting**: Enhanced syntax highlighting with `nvim-treesitter`.
- **Code Formatting**: Automatic code formatting with `null-ls.nvim`.
- **Clipboard Integration**: Seamless copy-paste functionality with system clipboard.

## Installation

### Prerequisites

- [Neovim](https://neovim.io/) (version 0.5 or later)
- [Git](https://git-scm.com/)
- A terminal emulator

### Steps

1. **Clone the Repository**

   ```sh
   git clone https://github.com/your-username/neovish.git ~/.config/nvim
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

### Plugins

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Enhanced syntax highlighting
- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: LSP configurations
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Autocompletion
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: Snippet engine
- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)**: Manage external tools
- **[williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)**: Bridge between Mason and LSPconfig
- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: Fuzzy finder
- **[jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)**: Code formatting and diagnostics

### LSP Servers

- **lua_ls**: Lua
- **pyright**: Python
- **tsserver**: TypeScript

### Indentation

- **Spaces**: 4 spaces per indentation level

### Line Numbers

- **Absolute Line Numbers**: Enabled
- **Relative Line Numbers**: Enabled

## Contributing

Feel free to fork this repository and make your own changes. Pull requests are welcome!
