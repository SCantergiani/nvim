-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.python3_host_prog = "~/.venvs/neovim/bin/python"

-- DVC lsp support
vim.filetype.add({
  filename = {
    ["Dvcfile"] = "yaml",
    ["dvc.lock"] = "yaml",
  },
  extension = {
    dvc = "yaml",
  },
})
