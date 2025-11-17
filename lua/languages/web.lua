local lsp_core = require('core.lsp')

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
  capabilities = lsp_core.capabilities(),
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

vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  capabilities = lsp_core.capabilities(),
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = 'ignore'
      }
    }
  }
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  capabilities = lsp_core.capabilities(),
  settings = {
    json = {
      schemas = (function()
        local has_schemastore, schemastore = pcall(require, 'schemastore')
        if has_schemastore then
          return schemastore.json.schemas()
        end
        return {}
      end)(),
      validate = { enable = true }
    }
  }
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function(args)
    vim.lsp.start({ name = 'html', bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'scss', 'less' },
  callback = function(args)
    vim.lsp.start({ name = 'cssls', bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc' },
  callback = function(args)
    vim.lsp.start({ name = 'jsonls', bufnr = args.buf })
  end,
})