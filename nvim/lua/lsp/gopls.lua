return {
  settings = {
    gopls = {
      -- Load files behind //go:build smoke (e.g. the standalone e2e/ smoke-test module).
      -- No main-module files use this tag, so it has no effect there.
      buildFlags = { "-tags=smoke" },
    },
  },
}
