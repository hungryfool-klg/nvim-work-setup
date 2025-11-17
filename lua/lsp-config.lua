-- Modern LSP configuration using vim.lsp.config()

-- Global defaults for all LSP clients
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = { multilineTokenSupport = true },
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" }
          }
        }
      }
    }
  },
  root_markers = { '.git' },
  flags = {
    debounce_text_changes = 150,
  }
})

-- TypeScript/JavaScript LSP
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'literal',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

-- Vue LSP
vim.lsp.config('volar', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', 'vue.config.js', 'nuxt.config.js' },
  settings = {
    vue = {
      complete = {
        casing = {
          tags = 'kebab',
          props = 'camel'
        }
      }
    }
  }
})

-- Lua LSP
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luacheckrc', 'lua/' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  }
})

-- C# LSP
vim.lsp.config('omnisharp', {
  cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
  filetypes = { 'cs' },
  root_markers = { '*.sln', '*.csproj', 'omnisharp.json' },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    }
  }
})

-- Dart/Flutter LSP
vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml' },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    }
  }
})

-- Go LSP
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    }
  }
})

-- HTML LSP
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = 'auto',
      }
    }
  }
})

-- CSS LSP
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = 'ignore'
      }
    }
  }
})

-- JSON LSP
vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
})

-- LSP keymaps and handlers
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  
  -- Highlight symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.INFO] = '⚠',
      [vim.diagnostic.severity.HINT] = '⚡',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Setup on_attach for all clients
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, args.buf)
    end
  end,
})

-- Auto-start LSP clients when opening files
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    
    -- Start appropriate LSP client based on filetype
    if filetype == 'lua' then
      vim.lsp.start({ name = 'lua_ls', bufnr = bufnr })
    elseif filetype == 'javascript' or filetype == 'javascriptreact' or filetype == 'typescript' or filetype == 'typescriptreact' then
      vim.lsp.start({ name = 'ts_ls', bufnr = bufnr })
    elseif filetype == 'vue' then
      vim.lsp.start({ name = 'volar', bufnr = bufnr })
    elseif filetype == 'cs' then
      vim.lsp.start({ name = 'omnisharp', bufnr = bufnr })
    elseif filetype == 'dart' then
      vim.lsp.start({ name = 'dartls', bufnr = bufnr })
    elseif filetype == 'go' or filetype == 'gomod' or filetype == 'gowork' or filetype == 'gotmpl' then
      vim.lsp.start({ name = 'gopls', bufnr = bufnr })
    elseif filetype == 'html' then
      vim.lsp.start({ name = 'html', bufnr = bufnr })
    elseif filetype == 'css' or filetype == 'scss' or filetype == 'less' then
      vim.lsp.start({ name = 'cssls', bufnr = bufnr })
    elseif filetype == 'json' or filetype == 'jsonc' then
      vim.lsp.start({ name = 'jsonls', bufnr = bufnr })
    end
  end,
})