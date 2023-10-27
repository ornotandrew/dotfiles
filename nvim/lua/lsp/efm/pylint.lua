return {
    lintCommand = 'pylint --output-format text --score no --reports no ${INPUT}',
    rootMarkers = { 'setup.cfg', '.pylintrc' },
    lintFormats = { '%f:%l:%c: C%n: %m' },
    lintStdin = false,
}
