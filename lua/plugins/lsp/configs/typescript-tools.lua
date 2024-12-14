---@type NvPluginSpec
-- NOTE: For Typescript

local keymaps = require("plugins.lsp.opts").lsp_keymaps

-- copied from
return {
  "pmizio/typescript-tools.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      keymaps(bufnr)
    end,
    settings = {
      separate_diagnostic_server = false, -- Disable separate diagnostic server
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      expose_as_code_action = { "all" },
    },
  },
}
