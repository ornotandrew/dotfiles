# LSP binaries

I use [lspconfig](https://github.com/neovim/nvim-lspconfig/). The below command will install the binaries I need for my setup. See [server configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for more info.

```shell
npm i -g \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    yaml-language-server \
    @fsouza/prettierd \
    vscode-eslint-language-server \
    graphql-language-service-cli


brew install \
    hashicorp/tap/terraform-ls \
    lua-language-server


go install \
    github.com/sqls-server/sqls@latest \
    golang.org/x/tools/gopls@latest
```
