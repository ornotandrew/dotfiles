-- Jump-to-definition for JSON `$ref` keys in YAML files (OpenAPI, JSON Schema).
-- yaml-language-server only resolves YAML anchors (&foo / *foo), not `$ref`.

local M = {}

local function strip_quotes(s)
  s = s:gsub("^['\"]", "")
  s = s:gsub("['\"]$", "")
  return s
end

local function decode_pointer(seg)
  seg = seg:gsub("~1", "/")
  seg = seg:gsub("~0", "~")
  return seg
end

local function find_first_mapping(node)
  if not node then return nil end
  local t = node:type()
  if t == "block_mapping" or t == "flow_mapping" then
    return node
  end
  for child in node:iter_children() do
    local m = find_first_mapping(child)
    if m then return m end
  end
  return nil
end

local function find_pair_in_mapping(mapping, key, bufnr)
  for child in mapping:iter_children() do
    local t = child:type()
    if t == "block_mapping_pair" or t == "flow_pair" then
      local key_field = child:field("key")[1]
      if key_field then
        local key_text = strip_quotes(vim.treesitter.get_node_text(key_field, bufnr))
        if key_text == key then return child end
      end
    end
  end
  return nil
end

local function find_node_by_pointer(bufnr, segments)
  local ok, lang_tree = pcall(vim.treesitter.get_parser, bufnr, "yaml")
  if not ok or not lang_tree then return nil end
  local tree = lang_tree:parse()[1]
  if not tree then return nil end

  local mapping = find_first_mapping(tree:root())
  for i, seg in ipairs(segments) do
    if not mapping then return nil end
    local pair = find_pair_in_mapping(mapping, seg, bufnr)
    if not pair then return nil end
    if i == #segments then
      return pair:field("key")[1] or pair
    end
    local value = pair:field("value")[1]
    mapping = find_first_mapping(value)
  end
  return nil
end

-- Tries to follow a `$ref` under the cursor. Returns true if it handled
-- the jump (or attempted and failed verbosely), false to fall through.
function M.try_jump()
  local line = vim.api.nvim_get_current_line()
  local ref = line:match([[%$ref:%s*['"]?([^'"%s]+)['"]?]])
  if not ref then return false end

  local file, fragment = ref:match("^(.-)#(.*)$")
  if not file then file, fragment = ref, "" end

  vim.cmd("normal! m'")

  local target_buf = vim.api.nvim_get_current_buf()
  if file ~= "" then
    local cur_dir = vim.fn.expand("%:p:h")
    local path = vim.fn.simplify(cur_dir .. "/" .. file)
    if vim.fn.filereadable(path) == 0 then
      vim.notify("openapi_ref: cannot read " .. path, vim.log.levels.ERROR)
      return true
    end
    vim.cmd("edit " .. vim.fn.fnameescape(path))
    target_buf = vim.api.nvim_get_current_buf()
  end

  if fragment == "" then return true end

  local segments = {}
  for seg in fragment:gmatch("[^/]+") do
    table.insert(segments, decode_pointer(seg))
  end

  local node = find_node_by_pointer(target_buf, segments)
  if not node then
    vim.notify("openapi_ref: could not resolve " .. ref, vim.log.levels.WARN)
    return true
  end

  local row, col = node:start()
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
  vim.cmd("normal! zz")
  return true
end

return M
