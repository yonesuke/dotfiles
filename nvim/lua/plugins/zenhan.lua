-- Force IME to English when leaving Insert/Command mode using zenhan
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  pattern = "*",
  callback = function()
    if vim.fn.has("win32") == 1 then
      vim.fn.system("zenhan 0")
    end
  end,
})

return {}
