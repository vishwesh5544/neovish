
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
