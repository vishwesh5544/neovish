-- ~/.config/nvim/lua/vish/config/plugins/init.lua
return {
    -- Example plugins
    { "nvim-treesitter/nvim-treesitter",  run = ":TSUpdate" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "nvim-telescope/telescope.nvim",    requires = { { 'nvim-lua/plenary.nvim' } } },
    { "folke/neodev.nvim" },
    { "github/copilot.vim" },
    --{ "jose-elias-alvarez/null-ls.nvim" },

    { "catppuccin/nvim",                  name = "catppuccin",                     priority = 1000 },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- lsp
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
    { 'hrsh7th/cmp-nvim-lsp' },
}
