---@type NvPluginSpec
-- NOTE: Package installer
return {
  "williamboman/mason.nvim",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  init = function()
    vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason | Installer", silent = true })
  end,
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonInstallAll",
    "MasonUpdate",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason = require "mason"
      -- local path = require "mason-core.path"
      local mason_lspconfig = require "mason-lspconfig"

      mason.setup {
        ui = {
          border = vim.g.border_enabled and "rounded" or "none",
          -- Whether to automatically check for new versions when opening the :Mason window.
          check_outdated_packages_on_open = true,
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        -- install_root_dir = path.concat { vim.fn.stdpath "config", "/lua/custom/mason" },
      }

      mason_lspconfig.setup {
        ensure_installed = {},
        automatic_enable = {
          exclude = {
            "jdtls",
            "rust_analyzer",
            "ts_ls",
          },
        },
      }
    end,
  },
  opts = {
    registries = {
      "github:nvim-java/mason-registry",
      "github:mason-org/mason-registry",
    },
  },
  ensure_installed = {
    "ansible-language-server",
    "ansible-lint",
    "autotools-language-server",
    "css-lsp",
    "delve",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "go-debug-adapter",
    "goimports",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "gopls",
    "html-lsp",
    "kotlin-language-server",
    "lua-language-server",
    "marksman",
    "stylua",
    "prettier",
    "terraform-ls",
    "tflint",
    -- "tfsec", -- replaced by trivy
    "trivy",
    "typescript-language-server",
    "yaml-language-server",
  },
}
