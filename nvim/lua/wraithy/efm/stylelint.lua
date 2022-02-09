return {
  lintCommand = 'npx stylelint_d --formatter unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %m [%t%*[a-z]]'
  },
  formatCommand = 'npx stylelint_d --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}
