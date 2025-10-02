---@type NvPluginSpec
-- NOTE: AI Provider for Avante

return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  event = "InsertEnter",
  init = function()
    require("legendary").commands {
      itemgroup = "Copilot",
      commands = {
        {
          ":CopilotToggle",
          function()
            require("copilot.suggestion").toggle_auto_trigger()
          end,
          description = "Toggle on/off for buffer",
        },
      },
    }
    require("legendary").keymaps {
      itemgroup = "Copilot",
      description = "Copilot suggestions...",
      icon = "",
      keymaps = {
        {
          "<C-a>",
          function()
            require("copilot.suggestion").accept()
          end,
          description = "Accept suggestion",
          mode = { "i" },
        },
        {
          "<C-x>",
          function()
            require("copilot.suggestion").dismiss()
          end,
          description = "Dismiss suggestion",
          mode = { "i" },
        },
        {
          "<C-\\>",
          function()
            require("copilot.panel").open()
          end,
          description = "Show Copilot panel",
          mode = { "n", "i" },
        },
      },
    }
  end,
  opts = {
    copilot_model = "gpt-4o-copilot",
    panel = {
      -- It is recommended to disable copilot.lua's suggestion and panel modules, as they can interfere with completions properly appearing in copilot-cmp
      enabled = true,
      auto_refresh = true,
    },
    suggestion = {
      -- It is recommended to disable copilot.lua's suggestion and panel modules, as they can interfere with completions properly appearing in copilot-cmp
      enabled = true,
      auto_trigger = true, -- Suggest as we start typing
      keymap = {
        accept_word = "<C-l>",
        accept_line = "<C-j>",
      },
    },
    filetypes = {
      ["*"] = function()
        local cwd = vim.loop.cwd()
        local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        local filepath = vim.api.nvim_buf_get_name(0)

        local dir_match = function(dirs)
          for _, dir in ipairs(dirs) do
            if cwd:match(dir) ~= nil then
              return true
            end
          end
          return false
        end

        if
        -- disable for certain projets
        -- disable for all hidden files
        -- disable for terraform .tfvars
            dir_match { "evergreen%-dissemination", "norsk" } or
            filename:match "^%." or
            filepath:match "%.tfvars$"
        then
          return false
        end
        return true
      end,
    },
  },
}
