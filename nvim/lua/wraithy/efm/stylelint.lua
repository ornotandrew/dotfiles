return {
  lintCommand = 'npx stylelint_d --stdin --stdin-filename ${INPUT} --formatter compact',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f: line %l, col %c, %tarning - %m',
    '%f: line %l, col %c, %trror - %m',
  },
  formatCommand = 'npx stylelint_d --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}
