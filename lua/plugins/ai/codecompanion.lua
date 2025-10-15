---@type NvPluginSpec
-- NOTE: Code Companion

return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional
    {
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      opts = {},
    },
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  config = function()
    require("codecompanion").setup {
      adapters = {
        http = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              -- suggested by @lucobellic (ref: https://github.com/olimorris/codecompanion.nvim/discussions/279) to improve responses from the copilot models
              -- see also https://github.com/lucobellic/nvim-config/blob/d8b0e7d34652704cfba85c130663823a0200bf77/lua/plugins/completion/codecompanion.lua#L53
              opts = { stream = false },
              schema = {
                model = {
                  -- https://platform.openai.com/docs/models
                  default = "gpt-4o",
                },
              },
            })
          end,
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              -- env = {
              --   api_key = os.getenv "GEMINI_API_KEY",
              -- },
              schema = {
                model = {
                  -- https://ai.google.dev/gemini-api/docs/models/experimental-models
                  default = require("serpro69.plugins_aux").ai_models.gemini.pro,
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
        agent = {
          adapter = "gemini",
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
          },
        },
        inline = {
          diff = {
            hl_groups = {
              added = "DiffAdd",
            },
          },
        },
      },
      opts = {
        log_level = "DEBUG",
      },
      -- extensions = {
      --   mcphub = {
      --     callback = "mcphub.extensions.codecompanion",
      --     opts = {
      --       make_vars = true,
      --       make_slash_commands = true,
      --       show_result_in_chat = true,
      --     },
      --   },
      -- },
    }
  end,
  init = function()
    vim.cmd [[cab cc CodeCompanion]]
    require("legendary").keymaps {
      {
        itemgroup = "CodeCompanion",
        icon = "",
        description = "Use the power of AI...",
        keymaps = {
          {
            "<C-a>",
            "<cmd>CodeCompanionActions<CR>",
            description = "Open the CodeCompanion action picker",
            mode = { "n", "v" },
          },
          {
            "<LocalLeader>a",
            "<cmd>CodeCompanionToggle<CR>",
            description = "Open CodeCompanion chat prompt",
            mode = { "n", "v" },
          },
          {
            "ga",
            "<cmd>CodeCompanionAdd<CR>",
            description = "Add selected text to CodeCompanion",
            mode = { "n", "v" },
          },
        },
      },
    }
  end,
}
