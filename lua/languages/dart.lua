local lsp_core = require('core.lsp')

vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
  capabilities = lsp_core.capabilities(),
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    }
  }
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dart',
  callback = function(args)
    vim.lsp.start({ name = 'dartls', bufnr = args.buf })
  end,
})