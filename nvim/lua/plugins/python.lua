return {
  -- pyrightをLSPとして有効化
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {},
        pyright = { enabled = false },
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
