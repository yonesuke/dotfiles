-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 相対行の出力を消す
vim.opt.relativenumber = false
-- 折り返し表示
vim.opt.linebreak = true

-- teminal表示方法
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- 自動保存
vim.opt.autowriteall = true

-- システムクリップボードとの連携
vim.opt.clipboard = "unnamedplus"
