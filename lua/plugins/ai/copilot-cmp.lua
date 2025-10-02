---@type NvPluginSpec
-- NOTE: AI copilot cmp integration

return {
  "zbirenbaum/copilot-cmp",
  enabled = false,
  config = function()
    require("copilot_cmp").setup()
  end,
}
