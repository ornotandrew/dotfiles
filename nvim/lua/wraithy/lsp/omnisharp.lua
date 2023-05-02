local pid = vim.fn.getpid()
local omnisharp_dll = "/Users/andrew/.vscode/extensions/ms-dotnettools.csharp-1.25.4-darwin-arm64/.omnisharp/1.39.4-net6.0/OmniSharp.dll"

return {
    cmd = { "dotnet", omnisharp_dll, "--languageserver" , "--hostPID", tostring(pid) };
}
