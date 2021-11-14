return {
  lintCommand = "sqlfluff lint ${INPUT}",
  lintStdin = false,
  -- L:  29 | P:  46 | L011 | Implicit aliasing of table not allowed. Use explicit
  lintFormats = {"L: %l | P: %c | | %m"}
}
