return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false, -- 手動でマッピングする
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          end
        end,
        mode = "i",
        desc = "Accept Copilot or insert Tab",
      },
    },
  },
}
