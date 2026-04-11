-- Read in 12 random hex chars
local function generate_uuid(with_dashes)
  local chars
  if (with_dashes) then
    chars = io.popen('uuidgen | tr -d " \t\n" | tr "[:upper:]" "[:lower:]"'):read('*a')
  else
    chars = io.popen('uuidgen | tr -d " \t\n-" | tr "[:upper:]" "[:lower:]"'):read('*a')
  end
  vim.fn.setreg('"', chars)
  return vim.api.nvim_command('norm! ""p')
end

vim.keymap.set('n', '<Leader>u', function() generate_uuid(false) end, { noremap = true })
vim.keymap.set('n', '<Leader>U', function() generate_uuid(true) end, { noremap = true })
--
-- Get GitLab permalink for the selected lines
local function get_gitlab_permalink()
  -- Get visual selection range
  local currentLine = vim.fn.getpos('.')[2]
  local startOfSelection = vim.fn.getpos('v')[2]
  local start_line, end_line = math.min(currentLine, startOfSelection), math.max(currentLine, startOfSelection)

  -- Get current file path relative to git root
  local file_path = vim.fn.expand('%:p')
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local relative_path = file_path:sub(#git_root + 2) -- +2 to remove the leading slash

  -- Get git remote URL
  local remote_url = vim.fn.systemlist('git remote get-url origin')[1]

  -- Convert SSH URL to HTTPS if needed
  if remote_url:match('^git@') then
    remote_url = remote_url:gsub('git@([^:]+):(.+).git$', 'https://%1/%2')
  end

  -- Format as GitLab permalink (always use main branch)
  local permalink = string.format(
    "%s/-/blob/main/%s#L%d-%d",
    remote_url:gsub('%.git$', ''),
    relative_path,
    start_line,
    end_line
  )

  -- Copy to clipboard
  vim.fn.setreg('+', permalink)
  vim.notify('Copied GitLab permalink to clipboard!')
  return permalink
end

-- Visual mode mapping
vim.keymap.set('v', '<Leader>gl', function() get_gitlab_permalink() end, { noremap = true, silent = true })
