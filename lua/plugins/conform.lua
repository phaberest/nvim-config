local formatters = {
  lua = { 'stylua' },
  python = { 'autopep8' },
  cpp = { 'clang_format' },
  c = { 'clang_format' },
  go = { 'gofumpt' },
  cs = { 'csharpier' },
  yaml = { 'yamlfmt' },
}

local prettier_ft = {
  'css',
  'flow',
  'graphql',
  'html',
  'json',
  'javascriptreact',
  'javascript',
  'less',
  'markdown',
  'scss',
  'typescript',
  'typescriptreact',
  'vue',
}

for _, filetype in pairs(prettier_ft) do
  formatters[filetype] = { 'prettier' }
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = formatters,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
