-- NOTE: plugin extras
local M = {}

M.ai_models = {
  claude = {
    sonnet_3_5 = "claude-3.5-sonnet",
    sonnet_3_7 = "claude-3.7-sonnet",
  },
  -- https://ai.google.dev/gemini-api/docs/models
  gemini = {
    flash = "gemini-2.5-flash",
    pro = "gemini-2.5-pro",
  },
}

M.keymaps = {
  nvim_tree = function(api, opts, bufnr)
    -- region Add file/folder to avante
    -- based on https://github.com/yetone/avante.nvim?tab=readme-ov-file#neotree-shortcut
    vim.keymap.set("n", "oa", function()
      local node = api.tree.get_node_under_cursor()
      if not node then
        return
      end

      local filepath = node.absolute_path
      local relative_path = require("avante.utils").relative_path(filepath)

      local sidebar = require("avante").get()

      local open = sidebar:is_open()
      -- ensure avante sidebar is open
      if not open then
        require("avante.api").ask()
        sidebar = require("avante").get()
      end

      sidebar.file_selector:add_selected_file(relative_path)

      -- remove nvim-tree buffer if it wasn't open before
      if not open then
        sidebar.file_selector:remove_selected_file "NvimTree_1"
      end
    end, opts "Add to Avante Selected Files")
    -- endregion

    -- region ARIA navigation
    -- ref: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#basic-aria-navigation-arrows-and-vim-keys
    api.config.mappings.default_on_attach(bufnr)
    -- function for left to assign to keybindings
    local lefty = function()
      local node_at_cursor = api.tree.get_node_under_cursor()
      -- if it's a node and it's open, close
      if node_at_cursor.nodes and node_at_cursor.open then
        api.node.open.edit()
      -- else left jumps up to parent
      else
        api.node.navigate.parent()
      end
    end
    -- function for right to assign to keybindings
    local righty = function()
      local node_at_cursor = api.tree.get_node_under_cursor()
      -- if it's a closed node, open it
      if node_at_cursor.nodes and not node_at_cursor.open then
        api.node.open.edit()
      end
    end
    vim.keymap.set("n", "h", lefty, opts "Close open node, or jump up to parent")
    vim.keymap.set("n", "<Left>", lefty, opts "Close open node, or jump up to parent")
    vim.keymap.set("n", "<Right>", righty, opts "Open closed node")
    vim.keymap.set("n", "l", righty, opts "Open closed node")
    -- endregion
  end,
}

return M
