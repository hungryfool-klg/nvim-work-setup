# Neovim Language-Based Configuration

A modular Neovim configuration organized by programming languages with comprehensive LSP, formatting, and tooling support.

## 📁 Structure

```
lua/
├── config/          # Core Neovim settings
│   ├── options.lua  # Vim options
│   └── keymaps.lua  # General keybindings
├── core/            # Core functionality
│   ├── lsp.lua      # LSP base setup
│   └── diagnostics.lua # Diagnostic configuration
├── languages/       # Language-specific configurations
│   ├── init.lua     # Loads all language configs
│   ├── typescript.lua # TypeScript/JavaScript
│   ├── vue.lua      # Vue.js
│   ├── lua.lua      # Lua
│   ├── go.lua       # Go
│   ├── rust.lua     # Rust
│   ├── csharp.lua   # C#
│   ├── dart.lua     # Dart/Flutter
│   └── web.lua      # HTML/CSS/JSON
└── plugins/         # Plugin configurations
    ├── init.lua     # Plugin manager setup
    ├── ui.lua       # UI plugins
    ├── editing.lua  # LSP, completion, formatting
    ├── navigation.lua # File navigation
    ├── git.lua      # Git integration
    └── ai.lua       # AI tools
```

## 🚀 Quick Start

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone <your-repo> ~/.config/nvim
   ```

3. **Install prerequisites** (see language-specific sections below)

4. **Launch Neovim**:
   ```bash
   nvim
   ```
   Plugins will install automatically on first run.

## 📋 Prerequisites by Language

### 🟨 JavaScript/TypeScript

**Files**: `languages/typescript.lua`

**Required**:
- **Node.js** (v18+)
  ```bash
  # Ubuntu/Debian
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs

  # macOS
  brew install node

  # Or use nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  nvm install 20
  ```

- **TypeScript Language Server**
  ```bash
  npm install -g typescript typescript-language-server
  ```

- **ESLint Language Server**
  ```bash
  npm install -g vscode-langservers-extracted
  ```

- **Prettier** (formatting)
  ```bash
  npm install -g prettier
  ```

**Optional project-level packages**:
```bash
# In your project directory
npm install --save-dev eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

### 🟩 Vue.js

**Files**: `languages/vue.lua`

**Required**:
- **Node.js** (see TypeScript section)
- **Vue Language Server**
  ```bash
  npm install -g @vue/language-server
  ```

### 🌙 Lua

**Files**: `languages/lua.lua`

**Required**:
- **Lua Language Server**
  ```bash
  # Ubuntu/Debian
  sudo apt install lua-language-server

  # macOS
  brew install lua-language-server

  # Manual install
  wget https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-3.7.4-linux-x64.tar.gz
  tar -xzf lua-language-server-*.tar.gz -C ~/.local/share/
  ln -s ~/.local/share/lua-language-server/bin/lua-language-server ~/.local/bin/
  ```

- **Stylua** (formatting)
  ```bash
  # Cargo
  cargo install stylua

  # GitHub releases
  wget https://github.com/JohnnyMorganz/StyLua/releases/latest/download/stylua-linux.zip
  unzip stylua-linux.zip -d ~/.local/bin/
  chmod +x ~/.local/bin/stylua
  ```

### 🐹 Go

**Files**: `languages/go.lua`

**Required**:
- **Go** (v1.19+)
  ```bash
  # Ubuntu/Debian
  sudo apt remove golang-go  # Remove old version
  wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

  # macOS
  brew install go
  ```

- **gopls** (LSP)
  ```bash
  go install golang.org/x/tools/gopls@latest
  ```

**Verify installation**:
```bash
go version
gopls version
```

### 🦀 Rust

**Files**: `languages/rust.lua`

**Required**:
- **Rust** (stable toolchain)
  ```bash
  # Install rustup (official installer)
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source ~/.cargo/env

  # Or via package manager
  # Ubuntu/Debian
  sudo apt install rustc cargo

  # macOS
  brew install rust
  ```

- **rust-analyzer** (LSP)
  ```bash
  # Automatic installation via Mason (recommended)
  # Or manual install:
  rustup component add rust-analyzer
  ```

- **rustfmt** (formatting)
  ```bash
  rustup component add rustfmt
  ```

- **clippy** (linting)
  ```bash
  rustup component add clippy
  ```

**Optional tools**:
- **taplo** (TOML formatting)
  ```bash
  cargo install taplo-cli
  ```

**Verify installation**:
```bash
rustc --version
cargo --version
rust-analyzer --version
rustfmt --version
cargo clippy --version
```

### 💙 C#

**Files**: `languages/csharp.lua`

**Required**:
- **.NET SDK** (v6.0+)
  ```bash
  # Ubuntu/Debian
  wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-8.0

  # macOS
  brew install dotnet

  # Arch Linux
  sudo pacman -S dotnet-sdk
  ```

- **OmniSharp** (LSP)
  ```bash
  # Install via Mason (recommended - automatic)
  # Or manual install:
  wget https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64.tar.gz
  mkdir -p ~/.local/share/omnisharp
  tar -xzf omnisharp-linux-x64.tar.gz -C ~/.local/share/omnisharp
  ln -s ~/.local/share/omnisharp/OmniSharp ~/.local/bin/omnisharp
  chmod +x ~/.local/bin/omnisharp
  ```

- **CSharpier** (formatting)
  ```bash
  dotnet tool install -g csharpier
  ```

**Verify installation**:
```bash
dotnet --version
omnisharp --version
csharpier --version
```

### 🎯 Dart/Flutter

**Files**: `languages/dart.lua`

**Required**:
- **Flutter SDK**
  ```bash
  # Download Flutter
  wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.5-stable.tar.xz
  tar xf flutter_linux_*.tar.xz
  sudo mv flutter /opt/
  echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc

  # macOS
  brew install flutter
  ```

- **Dart SDK** (included with Flutter)
  ```bash
  flutter doctor  # Verify installation
  ```

**Verify installation**:
```bash
flutter --version
dart --version
```

### 🌐 Web Technologies (HTML/CSS/JSON)

**Files**: `languages/web.lua`

**Required**:
- **HTML Language Server**
  ```bash
  npm install -g vscode-langservers-extracted
  ```

- **CSS Language Server**
  ```bash
  npm install -g vscode-langservers-extracted
  ```

- **JSON Language Server**
  ```bash
  npm install -g vscode-langservers-extracted
  ```

- **jq** (JSON formatting)
  ```bash
  # Ubuntu/Debian
  sudo apt install jq

  # macOS
  brew install jq

  # Manual install
  wget https://github.com/stedolan/jq/releases/latest/download/jq-linux64
  chmod +x jq-linux64
  sudo mv jq-linux64 /usr/local/bin/jq
  ```

## 🔧 Tool Installation via Mason

Most language servers can be installed automatically via Mason:

1. Open Neovim
2. Run `:Mason`
3. Search for language servers (e.g., `ts_ls`, `lua_ls`, `gopls`)
4. Press `i` to install

**Auto-installed via Mason**:
- `ts_ls` (TypeScript)
- `eslint` (ESLint)
- `lua_ls` (Lua)
- `rust_analyzer` (Rust)
- `omnisharp` (C#)

## 🎨 Formatters

All formatters are configured to run on save. Manual formatting: `<leader>f`

| Language | Formatter | Install Command |
|----------|-----------|-----------------|
| Lua | stylua | `cargo install stylua` |
| JavaScript/TypeScript | prettier | `npm install -g prettier` |
| Vue | prettier | `npm install -g prettier` |
| Rust | rustfmt | `rustup component add rustfmt` |
| TOML | taplo | `cargo install taplo-cli` |
| JSON | jq → prettier | `sudo apt install jq` |
| CSS | prettier | `npm install -g prettier` |
| HTML | prettier | `npm install -g prettier` |
| C# | csharpier | `dotnet tool install -g csharpier` |

## 🎯 Key Bindings

### LSP Commands
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Show hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>f` - Format document
- `[d` / `]d` - Previous/next diagnostic

### File Navigation
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>e` - Toggle file explorer
- `<leader>-` - Open parent directory

### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git pull

### Rust-specific
- `<leader>rr` - Cargo run
- `<leader>rt` - Cargo test
- `<leader>rb` - Cargo build
- `<leader>rc` - Cargo check
- `<leader>rC` - Cargo clippy
- `<leader>rf` - Cargo format
- `<leader>rd` - Cargo doc --open

### Debug (Rust DAP)
- `<leader>dd` - Toggle breakpoint
- `<leader>dc` - Debug continue
- `<leader>dn` - Debug step over
- `<leader>di` - Debug step into
- `<leader>do` - Debug step out

## 🔍 Diagnostics

Diagnostic signs:
- ✘ Error
- ▲ Warning
- ⚠ Info
- ⚡ Hint

## 🐛 Troubleshooting

### Language Server Not Starting

1. **Check if language server is installed**:
   ```bash
   which typescript-language-server
   which lua-language-server
   which gopls
   which rust-analyzer
   ```

2. **Check LSP status**:
   ```vim
   :LspInfo
   ```

3. **Install missing servers**:
   ```vim
   :Mason
   ```

### Formatter Not Working

1. **Check if formatter is installed**:
   ```bash
   which prettier
   which stylua
   which rustfmt
   which taplo
   which jq
   ```

2. **Check conform status**:
   ```vim
   :ConformInfo
   ```

### Performance Issues

1. **Disable unused language servers**:
   Edit `languages/init.lua` and comment out unused languages

2. **Reduce treesitter parsers**:
   Edit `plugins/editing.lua` and modify `ensure_installed` list

## 📚 Adding New Languages

1. **Create language file**:
   ```lua
   -- lua/languages/python.lua
   local lsp_core = require('core.lsp')

   vim.lsp.config('pyright', {
     cmd = { 'pyright-langserver', '--stdio' },
     filetypes = { 'python' },
     root_markers = { 'pyproject.toml', 'setup.py', '.git' },
     capabilities = lsp_core.capabilities(),
   })

   vim.api.nvim_create_autocmd('FileType', {
     pattern = 'python',
     callback = function(args)
       vim.lsp.start({ name = 'pyright', bufnr = args.buf })
     end,
   })
   ```

2. **Add to language loader**:
   ```lua
   -- lua/languages/init.lua
   local languages = {
     'typescript',
     'vue',
     'lua',
     'go',
     'rust',
     'csharp',
     'dart',
     'web',
     'python', -- Add your new language
   }
   ```

3. **Add formatter** (optional):
   ```lua
   -- lua/plugins/editing.lua
   formatters_by_ft = {
     -- existing formatters...
     rust = { "rustfmt" },
     python = { "black", "isort" },
   }
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add language configuration
4. Update this README
5. Submit a pull request

## 📄 License

MIT License