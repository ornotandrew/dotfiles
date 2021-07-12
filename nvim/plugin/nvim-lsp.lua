local sumneko_root_path = '/Users/andrew/github/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local black = require('wraithy.efm.black')
local isort = require('wraithy.efm.isort')
local pylint = require('wraithy.efm.pylint')

local servers = {
  efm = {
    init_options = {documentFormatting = true},
    filetypes = {"python"},
    settings = {
      rootMarkers = {".git/"},
      languages = {
        -- lua = {luafmt},
        -- python = {black, isort, flake8, mypy},
        python = {black, isort},
        -- typescript = {prettier, eslint},
        -- javascript = {prettier, eslint},
        -- typescriptreact = {prettier, eslint},
        -- javascriptreact = {prettier, eslint},
        -- yaml = {prettier},
        -- json = {prettier},
        -- html = {prettier},
        -- scss = {prettier},
        -- css = {prettier},
        -- markdown = {prettier},
        -- sh = {shellcheck},
        -- tf = {terraform}
      }
    }
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = 'warning',
            reportUnusedImport = 'warning'
          }
        }
      }
    }
  },
  rust_analyzer = {},
  tsserver = {},
  sumneko_lua = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>?', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>g', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)


  -- Format on save
  vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

  -- Show diagnostics on hover
  vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })')
  -- TODO: this kicks me out of insert mode - why?
  -- vim.api.nvim_command('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
end

local lspconfig = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for name, opts in pairs(servers) do
  opts.on_attach = on_attach
  opts.flags = { debounce_text_changes = 150 }
  lspconfig[name].setup(opts)
end

-- Disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
	}
)

-- Highlight colors
local fg_colors = {
  Error = '#ab4642',
  Warning = '#f7ca88',
  Information = '#7cafc2',
  Hint = '#7cafc2',
}
local signcolumn_bg_color = '#282828'

for level, fg in pairs(fg_colors) do
  vim.api.nvim_command('highlight LspDiagnosticsDefault'..level..' guifg='..fg..' guibg=none')
-- The above highlight groups look great in-buffer, but the signcolumn has the incorrect background
  vim.api.nvim_command('highlight LspDiagnosticsSign'..level..' guifg='..fg..' guibg='..signcolumn_bg_color)
end

-- Signs (for the signcolumn)
local signs = {
  Error = '✖',
  Warning = '⚠',
  Information = 'ℹ',
  Hint = '?',
}
for level, sign in pairs(signs) do
  vim.fn.sign_define('LspDiagnosticsSign'..level, {text = sign})
end
