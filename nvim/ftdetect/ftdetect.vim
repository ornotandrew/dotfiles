augroup custom
    autocmd BufNewFile,BufFilePre,BufRead *.md,*.markdown,*.mdx setlocal filetype=markdown
    autocmd BufNewFile,BufFilePre,BufRead Dockerfile*,*.dockerfile setlocal filetype=dockerfile
    autocmd BufNewFile,BufFilePre,BufRead *.ts setlocal filetype=typescript
    autocmd BufNewFile,BufFilePre,BufRead .babelrc setlocal filetype=json
    autocmd BufNewFile,BufRead .sqlfluff setlocal filetype=dosini
    autocmd BufNewFile,BufRead .env.* setlocal filetype=sh
    autocmd BufNewFile,BufRead Tiltfile setlocal filetype=python
    autocmd BufNewFile,BufRead *.snap setlocal filetype=javascript
augroup END
