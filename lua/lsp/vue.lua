-- Vue LSP specialized configuration
return {
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
      },
      updateImportsOnFileMove = {
        enabled = true,
      },
      inlayHints = {
        missingProps = true,
        inlineHandlerLeading = true,
        optionsWrapper = true,
        vBindShorthand = true,
      }
    }
  }
}