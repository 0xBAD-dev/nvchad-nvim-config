if vim.g.vscode then
  require "options"
  require "core.globals"
  require "vscode-config"
else
  require "options"
  require "core.globals"
  require "core.env"

  -- region Override with my own values
  require "core.serpro69.globals"
  require "serpro69.options" -- add/override vim options
  require "serpro69.commands" -- add/override custom vim commands
  -- endregion

  if vim.version().minor >= 11 then
    vim.tbl_add_reverse_lookup = function(tbl)
      for k, v in pairs(tbl) do
        tbl[v] = k
      end
    end
  end

  -- bootstrap lazy and all plugins
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
  end

  vim.opt.runtimepath:prepend(lazypath)

  -- NOTE: lazy.nvim options
  local lazy_config = require "core.lazy"

  -- NOTE: Load plugins
  require("lazy").setup({
    -- region Own Configs
    -- {
    --   "NvChad/NvChad",
    --   lazy = false,
    --   branch = "v2.5",
    --   import = "nvchad.plugins",
    -- },

    { import = "serpro69.nvchad" },
    -- endregion
    { import = "plugins" },
  }, lazy_config)

  -- Load the highlights
  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
  end

  require "nvchad.autocmds"
  require "core.commands"
  require "core.autocommands"
  require "core.filetypes"
  require "core.utils"
  require "mappings"

  -- region Own Configs
  require "serpro69.mappings"
  require "core.serpro69.init"
  require "core.serpro69.autocommands"
  require "serpro69.notify"
  -- endregion
end
