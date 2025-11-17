local languages = {
  'typescript',
  'vue',
  'lua',
  'go',
  'csharp',
  'dart',
  'web',
  'rust'
}

for _, lang in ipairs(languages) do
  require('languages.' .. lang)
end