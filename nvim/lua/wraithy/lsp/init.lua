require("wraithy.lsp.handlers")
local util = require("wraithy.util")

local servers = {
  efm = require("wraithy.lsp.efm"),
  pyright = require("wraithy.lsp.pyright"),
  eslint = {},
  rust_analyzer = {},
  lua_ls = {},
  tsserver = require("wraithy.lsp.tsserver"),
  jsonls = {},
  yamlls = require("wraithy.lsp.yamlls"),
  gopls = {},
  graphql = {},
  cssls = require("wraithy.lsp.cssls"),
  omnisharp = require("wraithy.lsp.omnisharp"),
}

-- Use on_attach to set up mappings/autocommands etc once LSP has attached to a buffer
local on_attach = function(client, bufnr)
  -- Allow each config to override the capabilities. Useful for e.g. disabling document formatting.
  client.server_capabilities = util.merge_tables(
    client.server_capabilities,
    client.config.override_server_capabilities or {}
  )

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<c-]>', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>n', ':lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>?', ':lua require("wraithy.telescope").lsp_references()<CR>', opts)
  buf_set_keymap('n', '[d', ':lua require("wraithy.lsp.functions").goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', ':lua require("wraithy.lsp.functions").goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', ':lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<C-o>:lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Format on save
  require('lsp-format').on_attach(client)

  -- Show diagnostics on hover
  vim.api.nvim_command('autocmd CursorHold * lua require("wraithy.lsp.functions").open_float()')
end

-- Call setup. Language servers are initialized here in order to support global
-- overrides (e.g. we always want to set on_attach).
for name, opts in pairs(servers) do
  require('lspconfig')[name].setup(util.merge_tables(opts, {
    on_attach = on_attach,
    -- cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities instead.
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text_changes = 150 }
  }))
end


-- Visual elements (signs and highlight colors)
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  virtual_text = false,
  float = {
    source = "if_many",
  },
})

local fg_colors = { Error = '#ab4642', Warn = '#f7ca88', Info = '#7cafc2', Hint = '#7cafc2' }
local signcolumn_bg_color = '#282828'

for level, fg in pairs(fg_colors) do
  vim.api.nvim_command('highlight Diagnostic' .. level .. ' guifg=' .. fg .. ' guibg=none')
  vim.api.nvim_command('highlight DiagnosticSign' .. level .. ' guifg=' .. fg .. ' guibg=' .. signcolumn_bg_color)
end

local signs = { Error = '✖', Warn = '⚠', Info = 'ℹ', Hint = '?' }
for level, sign in pairs(signs) do
  local hl = "DiagnosticSign" .. level
  vim.fn.sign_define(hl, { text = sign, texthl = hl, numhl = hl })
end
