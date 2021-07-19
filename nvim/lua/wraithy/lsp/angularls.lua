-- NOTE: Despite what CONFIG.md on nvim-lspconfig says, I needed to do the following
--
--  npm install -g @angular/language-service @angular/language-service
--
--  There seems to be some confusion between "server" and "service". It seems
--  like an issue with ngserver, and I'm not sure if both are needed.

local node_path = os.getenv("NODE_PATH")
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", node_path , "--ngProbeLocations", node_path}

return {
  cmd = cmd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
}
