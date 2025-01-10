require("lsp.handlers")
local util = require("wraithy.util")
local lsp_util = require("lsp.util")

local servers = {
  efm = require("lsp.efm"),
  pyright = require("lsp.pyright"),
  terraformls = {},
  eslint = {},
  rust_analyzer = {},
  lua_ls = require("lsp.lua_ls"),
  ts_ls = require("lsp.ts_ls"),
  jsonls = {},
  yamlls = require("lsp.yamlls"),
  gopls = {},
  graphql = require("lsp.graphql"),
  cssls = require("lsp.cssls"),
  omnisharp = require("lsp.omnisharp"),
  html = {},
  protols = {},
  elixirls = require("lsp.elixirls"),
}

-- Use on_attach to set up mappings/autocommands etc once LSP has attached to a buffer
local on_attach = function(client, bufnr)
  -- Allow each config to override the capabilities. Useful for e.g. disabling document formatting.
  client.server_capabilities = util.merge_tables(
    client.server_capabilities,
    client.config.override_server_capabilities or {}
  )

  local function buf_set_keymap(mode, key, fn)
    vim.keymap.set(mode, key, fn, { buffer = bufnr, remap = false, silent = true })
  end

  --Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<c-]>', vim.lsp.buf.definition)
  buf_set_keymap('n', 'K', vim.lsp.buf.hover)
  buf_set_keymap('n', '<leader>n', vim.lsp.buf.rename)
  buf_set_keymap('n', '<leader>a', vim.lsp.buf.code_action)
  buf_set_keymap('n', '<leader>?', require("wraithy.telescope_util").lsp_references)
  buf_set_keymap('n', '[d', lsp_util.goto_prev)
  buf_set_keymap('n', ']d', lsp_util.goto_next)
  buf_set_keymap('n', '<leader>q', function()
    vim.lsp.buf.format({ async = true })
  end)
  buf_set_keymap('i', '<C-k>', vim.lsp.buf.signature_help)

  -- Format on save
  require('lsp-format').on_attach(client, bufnr)

  -- Show diagnostics on hover
  vim.api.nvim_create_autocmd('CursorHold', { callback = lsp_util.open_float })

  -- Enable inlay hints
  if client.server_capabilities.inlayHintProvider then
    vim.g.inlay_hints_visible = true
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

-- Call setup. Language servers are initialized here in order to support global
-- overrides (e.g. we always want to set on_attach).
for name, opts in pairs(servers) do
  require('lspconfig')[name].setup(util.merge_tables(opts, {
    on_attach = on_attach,
    -- cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities instead.
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text_changes = 500 }
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

local colors = require("wraithy.colors")
local fg_colors = {
  Error = colors.base08,
  Warn = colors.base0A,
  Info = colors.base0D,
  Hint = colors.base0D
}
local signcolumn_bg_color = '#282828'

for level, fg in pairs(fg_colors) do
  vim.api.nvim_command('highlight Diagnostic' .. level .. ' guifg=' .. fg .. ' guibg=none')
  vim.api.nvim_command('highlight DiagnosticSign' .. level .. ' guifg=' .. fg .. ' guibg=' .. signcolumn_bg_color)
end

local signs = {
  Error = '✖',
  Warn = '⚠',
  Info = 'ℹ',
  Hint = '?'
}
for level, sign in pairs(signs) do
  local hl = "DiagnosticSign" .. level
  vim.fn.sign_define(hl, { text = sign, texthl = hl, numhl = hl })
end
