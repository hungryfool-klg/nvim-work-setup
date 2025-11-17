local lsp_core = require('core.lsp')

vim.lsp.config('omnisharp', {
  cmd = { 'omnisharp' },
  filetypes = { 'cs', 'vb' },
  root_markers = { '*.sln', '*.csproj', 'omnisharp.json', 'function.json', '.git' },
  capabilities = lsp_core.capabilities(),
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  cmd_env = {
    DOTNET_ROOT = vim.fn.expand("~/.dotnet"),
  },
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'vb' },
  callback = function(args)
    vim.lsp.start({ name = 'omnisharp', bufnr = args.buf })
  end,
})