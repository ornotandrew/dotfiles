augroup custom
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown setlocal filetype=markdown
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile*,*.dockerfile setlocal filetype=dockerfile
    autocmd BufNewFile,BufFilePre,BufRead *.ts setlocal filetype=typescript
    autocmd BufNewFile,BufFilePre,BufRead .babelrc setlocal filetype=json
    autocmd BufNewFile,BufRead *.prisma setfiletype graphql
augroup END
