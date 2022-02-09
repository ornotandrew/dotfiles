local util = require("wraithy.util")
local lsp_signature = require("lsp_signature")
local floating_window_border = require("wraithy.lsp.handlers")

local servers = {
  -- angularls = require("wraithy.lsp.angularls"),
  efm = require("wraithy.lsp.efm"),
  pyright = require("wraithy.lsp.pyright"),
  rust_analyzer = {},
  sumneko_lua = require("wraithy.lsp.sumneko_lua"),
  tsserver = require("wraithy.lsp.tsserver"),
  jsonls = require("wraithy.lsp.jsonls"),
  -- sqls = require("wraithy.lsp.sqls"),
  yamlls = require("wraithy.lsp.yamlls"),
  gopls = {},
  cssls = require("wraithy.lsp.cssls"),
  -- jedi_language_server = {},
}

-- Use on_attach to set up mappings/autocommands etc once LSP has attached to a buffer
local on_attach = function(client, bufnr)
  -- Allow each config to override the capabilities. Useful for e.g. disabling document formatting.
  client.resolved_capabilities = util.merge_tables(
    client.resolved_capabilities,
    client.config.override_resolved_capabilities or {}
  )


  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua require("wraithy.telescope").lsp_code_actions()<CR>', opts)
  -- TODO: why do I need this extra <Esc>? I'm getting a blank list of results without it.
  buf_set_keymap('v', '<leader>a', '<cmd>lua require("wraithy.telescope").lsp_range_code_actions()<CR><Esc>', opts)
  buf_set_keymap('n', '<leader>?', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end

  -- Show diagnostics on hover
  vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ border="'..floating_window_border..'", focusable = false })')

  -- Show function signature in insert mode
  lsp_signature.on_attach({ floating_window = false })
end

-- Call setup. Language servers are initialized here in order to support global
-- overrides (e.g. we always want to set on_attach).
for name, opts in pairs(servers) do
  require('lspconfig')[name].setup(util.merge_tables(opts, {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 }
  }))
end


-- Visual elements (signs and highlight colors)
local fg_colors = { Error = '#ab4642', Warning = '#f7ca88', Information = '#7cafc2', Hint = '#7cafc2' }
local signcolumn_bg_color = '#282828'

for level, fg in pairs(fg_colors) do
  vim.api.nvim_command('highlight LspDiagnosticsDefault'..level..' guifg='..fg..' guibg=none')
  vim.api.nvim_command('highlight LspDiagnosticsSign'..level..' guifg='..fg..' guibg='..signcolumn_bg_color)
end

local signs = { Error = '✖', Warning = '⚠', Information = 'ℹ', Hint = '?' }
for level, sign in pairs(signs) do
  vim.fn.sign_define('LspDiagnosticsSign'..level, {text = sign})
end
