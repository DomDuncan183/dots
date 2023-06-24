require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "python", "lua", "yaml", "bash", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true }
}
