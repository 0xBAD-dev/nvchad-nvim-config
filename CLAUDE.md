# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a customized Neovim configuration forked from [Alexis12119/nvim-config](https://github.com/Alexis12119/nvim-config), built on the NvChad foundation. It features extensive LSP support, AI integrations, debugging capabilities, and a modular plugin architecture.

**Requirements**: Neovim 0.11+

## Essential Commands

### Configuration Management

```bash
# Update configuration with latest upstream changes
make update

# Upgrade Neovim to latest version (Linux only)
make upgrade

# Format Lua code
stylua lua/ --config-path .stylua.toml
```

### Plugin Management

Plugins are managed via [lazy.nvim](https://github.com/folke/lazy.nvim):

- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Update all plugins to match lazy-lock.json
- `:Lazy update` - Update plugins and write to lazy-lock.json
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates
- Plugins auto-check for updates on startup (Linux only)

### LSP & Tools

```bash
# Install/manage LSP servers, formatters, linters, DAP
:Mason
:MasonInstall <package_name>
```

### Testing & Debugging

- `:Neotest` - Run tests via neotest
- `:DapToggleBreakpoint` - Toggle breakpoint
- `:DapContinue` - Start/continue debugging
- See `lua/plugins/dap/` for debugger configurations

### Code Quality

- Format on save is enabled via conform.nvim (see `lua/plugins/lsp/configs/conform.lua`)
- Linting via nvim-lint (see `lua/plugins/lsp/configs/nvim-lint.lua`)
- `:Compiler` - Compile code via compiler.nvim

## Architecture

### Entry Point & Load Sequence

**`init.lua`** is the entry point:

1. Checks for VSCode integration (loads minimal config if detected)
2. Loads core options and globals from `lua/options.lua` and `lua/core/globals.lua`
3. Applies custom overrides from `lua/core/serpro69/globals.lua` and `lua/serpro69/options.lua`
4. Bootstraps lazy.nvim plugin manager
5. Loads plugin specs from:
   - `lua/serpro69/nvchad.lua` (NvChad base plugins)
   - `lua/plugins/` (all plugin configurations)
6. Loads highlights, autocmds, commands, mappings

### Directory Structure

```
nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/                   # Core NvChad files
│   │   ├── lazy.lua           # lazy.nvim configuration
│   │   ├── utils.lua          # Utility functions (git, bootstrap, etc.)
│   │   ├── commands.lua       # User commands
│   │   ├── autocommands.lua   # Autocommands
│   │   ├── statusline/        # Custom statusline
│   │   ├── tabufline/         # Custom tabline
│   │   └── serpro69/          # Personal overrides
│   ├── plugins/               # Plugin configurations (modular)
│   │   ├── init.lua           # Plugin loader
│   │   ├── lsp/               # LSP configurations
│   │   │   ├── configs/       # LSP tool configs (nvim-lspconfig, conform, lint, etc.)
│   │   │   └── settings/      # Per-language LSP settings
│   │   ├── dap/               # Debug adapter configurations
│   │   │   └── settings/      # Per-language DAP settings
│   │   ├── completion/        # Completion engines (blink.cmp, nvim-cmp)
│   │   ├── ai/                # AI integrations (opencode, supermaven, copilot, etc.)
│   │   ├── navigation/        # Navigation plugins (telescope, nvim-tree, flash, etc.)
│   │   ├── editing/           # Editing plugins (nvim-surround, comment, etc.)
│   │   ├── version-control/   # Git plugins (gitsigns, lazygit, diffview, etc.)
│   │   ├── ui/                # UI enhancements (noice, notify, indent-blankline, etc.)
│   │   └── [other categories]
│   ├── serpro69/              # Personal customizations
│   │   ├── mappings.lua       # Custom keymaps
│   │   ├── commands.lua       # Custom commands
│   │   ├── options.lua        # Custom options
│   │   └── nvchad.lua         # NvChad plugin overrides
│   ├── themes/                # Custom color schemes
│   ├── mappings.lua           # Base keymaps
│   ├── options.lua            # Neovim options
│   ├── chadrc.lua             # NvChad configuration
│   └── highlights.lua         # Highlight overrides
├── after/                     # After-directory for late-loading configs
├── ftdetect/                  # Filetype detection
├── ftplugin/                  # Filetype-specific configs
├── snippets/                  # Custom snippets
└── lazy-lock.json             # Plugin version lock file
```

### Plugin Organization

Plugins are organized by category in `lua/plugins/`:

- **Core**: Essential plugins (treesitter, which-key, utils)
- **LSP**: Language server configurations and tools
- **DAP**: Debug adapter protocols
- **Completion**: Autocompletion engines
- **AI**: AI assistant integrations
- **Navigation**: File/buffer/project navigation
- **Editing**: Text editing enhancements
- **Version Control**: Git integrations
- **UI**: User interface improvements
- **Testing**: Test runners and frameworks
- **Terminal**: Terminal emulators
- **Database**: Database tools
- **Writing**: Markdown/documentation tools
- **Languages**: Language-specific plugins

### Configuration Pattern

Each plugin follows this structure:

```lua
-- lua/plugins/category/plugin-name.lua
return {
  "author/plugin-name",
  event = "LazyEvent",  -- or other lazy-loading triggers
  dependencies = {},
  opts = {},
  config = function(_, opts)
    -- Setup code
  end,
}
```

### Customization Layers

1. **Base Layer** (`lua/core/`, `lua/plugins/`): NvChad foundation
2. **Override Layer** (`lua/serpro69/`, `lua/core/serpro69/`): Personal customizations
3. Personal customizations take precedence and are loaded after base configs

### Key Integration Points

- **LSP**: Configured via `lua/plugins/lsp/configs/nvim-lspconfig.lua`
  - Language-specific settings in `lua/plugins/lsp/settings/`
  - Auto-setup via mason-lspconfig.nvim
- **Formatting**: conform.nvim with per-language formatters (see `lua/plugins/lsp/configs/conform.lua`)
- **Linting**: nvim-lint (see `lua/plugins/lsp/configs/nvim-lint.lua`)
- **Completion**: blink.cmp (primary) or nvim-cmp (alternative)
- **Snippets**: Integrated with completion engines
- **AI**: Multiple providers (opencode, supermaven, copilot, avante, codecompanion)

## Adding/Modifying Features

### Adding a New Plugin

1. Create file: `lua/plugins/category/plugin-name.lua`
2. Return plugin spec (see structure above)
3. Plugin auto-loads via `lua/plugins/init.lua`

### Modifying Keymaps

Edit `lua/mappings.lua` or `lua/serpro69/mappings.lua` for personal overrides.

Use `vim.keymap.set()`:
```lua
vim.keymap.set("n", "<leader>key", "<cmd>Command<cr>", { desc = "Description", silent = true })
```

### Customizing Options

Edit `lua/options.lua` or `lua/serpro69/options.lua` for overrides.

### Adding LSP Support

1. Most servers will install automatically on first run
2. Sometimes you may need to run `:MasonInstallAll`
3. To install individual LSP server: `:MasonInstall <server>`
4. Create settings file: `lua/plugins/lsp/settings/<server>.lua` (optional)
5. Server auto-configures via mason-lspconfig

### Adding Formatter/Linter

1. Install tool: `:MasonInstall <tool>`
2. Configure in `lua/plugins/lsp/configs/conform.lua` (formatter) or `lua/plugins/lsp/configs/nvim-lint.lua` (linter)

## Code Style

- **Lua formatter**: stylua with settings in `.stylua.toml`
  - Column width: 120
  - Indent: 2 spaces
  - Quote style: Auto-prefer double
  - Call parentheses: None
- Follow existing patterns in `lua/core/` and `lua/plugins/`
- Use descriptive comments with `-- NOTE:`, `-- region`, `-- endregion` markers

## Git Workflow

- Main development branch: `master`
- Upstream integration branch: `main`
- Must have clean working tree before running `make update`
- Configuration includes auto-session, so sessions persist across restarts

## Platform Support

- Primary: Linux
- Windows: Partial support upstream (installer, plugin updates disabled), not used in this fork.
- macOS: Supported (Homebrew for Neovim upgrades)

## External Dependencies

See README.md for full list. Key tools:
- fd, bat, ripgrep (for telescope)
- lazygit, lazydocker
- make, mingw (Windows)
- Nerd Font (JetBrainsMono recommended)

## Notes for Claude Code

- This configuration is highly modular - changes should respect the plugin category organization
- Personal customizations go in `lua/serpro69/` and `lua/core/serpro69/`
- Never modify `lazy-lock.json` directly - use `:Lazy` commands
- Test changes by restarting Neovim or `:Lazy reload <plugin>`
- Format Lua files before committing using stylua
