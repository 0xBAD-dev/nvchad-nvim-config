local keymap = vim.keymap.set

return {
  "jinzhongjia/LspUI.nvim",
  branch = "main",
  event = "LspAttach",
  enabled = false,
  init = function()
    -- Basic keybinding setup
    keymap("n", "K", "<cmd>LspUI hover<CR>", { desc = "LspUI | Hover", silent = true })
    keymap("n", "gr", "<cmd>LspUI reference<CR>", { desc = "LspUI | GoTo Reference", silent = true })
    keymap("n", "gd", "<cmd>LspUI definition<CR>", { desc = "LspUI | GoTo Definition", silent = true })
    keymap("n", "gt", "<cmd>LspUI type_definition<CR>", { desc = "LspUI | GoTo Type Definition ", silent = true })
    keymap("n", "gi", "<cmd>LspUI implementation<CR>", { desc = "LspUI | GoTo Implementation", silent = true })
    keymap("n", "<leader>lr", "<cmd>LspUI rename<CR>", { desc = "LspUI | Rename", silent = true })
    keymap("n", "<leader>la", "<cmd>LspUI code_action<CR>", { desc = "LspUI | Code Action", silent = true })
    keymap("v", "<leader>la", "<cmd>LspUI code_action<CR>", { desc = "LspUI | Code Action", silent = true })
    keymap(
      "n",
      "<leader>lI",
      "<cmd>LspUI call_hierarchy incoming_calls<CR>",
      { desc = "LspUI | Incoming Calls", silent = true }
    )
    keymap(
      "n",
      "<leader>lO",
      "<cmd>LspUI call_hierarchy outgoing_calls<CR>",
      { desc = "LspUI | Outgoing Calls", silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>lj",
      "<cmd>LspUI diagnostic next<cr>",
      { desc = "Lspsaga | Next Diagnostic", silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>lk",
      "<cmd>LspUI diagnostic prev<cr>",
      { desc = "Lspsaga | Prev Diagnostic", silent = true }
    )
  end,
  config = function()
    require("LspUI").setup {
      -- General settings
      prompt = {
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },

      -- Code Action configuration
      code_action = {
        enable = true,
        command_enable = true,
        gitsigns = false,
        extend_gitsigns = false,
        ui = {
          title = "Code Action",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
        },
      },

      -- Hover configuration
      hover = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Hover",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
        },
      },

      -- Rename configuration
      rename = {
        enable = true,
        command_enable = true,
        auto_save = false,
        ui = {
          title = "Rename",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
      },

      -- Diagnostic configuration
      diagnostic = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Diagnostic",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
        },
      },

      -- Definition configuration
      definition = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Definition",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Reference configuration
      reference = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Reference",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Implementation configuration
      implementation = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Implementation",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Type Definition configuration
      type_definition = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Type Definition",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Declaration configuration
      declaration = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Declaration",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Call Hierarchy configuration
      call_hierarchy = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Call Hierarchy",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
          exec = "<CR>",
          expand = "o",
          jump = "e",
          vsplit = "v",
          split = "s",
          tabe = "t",
        },
      },

      -- Lightbulb configuration
      lightbulb = {
        enable = true,
        command_enable = true,
        icon = "💡",
        action_kind = {
          QuickFix = "🔧",
          Refactor = "♻️",
          RefactorExtract = "📤",
          RefactorInline = "📥",
          RefactorRewrite = "✏️",
          Source = "📄",
          SourceOrganizeImports = "📦",
        },
      },

      -- Inlay Hint configuration
      inlay_hint = {
        enable = true,
        command_enable = true,
      },

      -- Signature Help configuration
      signature = {
        enable = true,
        command_enable = true,
        ui = {
          title = "Signature Help",
          border = "rounded",
          winblend = 0,
        },
        keys = {
          quit = "q",
        },
      },
    }
  end,
}
