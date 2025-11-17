local lsp_core = require('core.lsp')

vim.lsp.config('volar', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', 'vue.config.js', 'nuxt.config.js', '.git' },
  capabilities = lsp_core.capabilities(),
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vue',
  callback = function(args)
    vim.lsp.start({ name = 'volar', bufnr = args.buf })
  end,
})