return {
  { "nvim-mini/mini.pairs", enabled = false },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false, -- Disable scrolling animations
      },
    },
  },
  {
    "LazyVim/LazyVim", -- Diasable news alerts
    opts = {
      news = {
        lazyvim = false,
        neovim = false,
      },
    },
  },
}
