return {
  -- treesitterの設定
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" },
    },
  },
  -- pyrightをLSPとして有効化
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
  -- ruffでlinter
  {
    "mfussenegger/nvim-lint",
    opts = {
      liners_by_ft = {
        python = { "ruff" },
      },
    },
  },
  -- ruffで保存時に自動フォーマット
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
    },
  },
  -- 括弧のペア色分け
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
