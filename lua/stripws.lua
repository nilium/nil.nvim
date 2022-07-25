local M = {}

local default_options = {
  strip_trailing_ws = true,
  ignore = {
    'asciidoc',
    'diff',
    'gitcommit',
    'hgcommit',
    'markdown',
  }
}

local config = default_options

function M.strip_trailing_ws(force)
  if not force then
    if vim.tbl_contains(config.ignore, vim.o.filetype) then
      return
    end

    local should_strip = config.strip_trailing_ws or vim.b.strip_trailing_ws
    if not should_strip then
      return
    end
  end

  local pos = vim.fn.getpos('.')
  vim.cmd [[%s/\s\+$//e]]
  vim.fn.cursor(pos[2], pos[3], pos[4])
end

function M.setup(options)
  local new_options = vim.tbl_extend('force', {}, default_options, options or {})
  new_options.ignore = new_options.ignore or {}
  config = new_options

  local group = vim.api.nvim_create_augroup('grpStripTrailingWS', { clear = true })
  if config.strip_trailing_ws then
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = { '*' },
      callback = function() M.strip_trailing_ws(false) end,
      group = group,
    })
  end

  vim.api.nvim_create_user_command('StripWhitespace',
    [[lua require('stripws').strip_trailing_ws("<bang>" == "!")]],
    { bang = true })

  return M
end

M.init = M.setup, -- Deprecated.

return M
