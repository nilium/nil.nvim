local function cd_to_buf(local_only, bang)
  local global_cd = nil
  if vim.b.cdbuf_global then
    global_cd = vim.b.cdbuf_global
  end
  global_cd = global_cd or bang == '!'
  local dir = vim.fn.expand('%:p:h')
  local cmd = 'chdir'
  if local_only or not global_cd then
    cmd = 'lchdir'
  end
  vim.cmd({ cmd = cmd, args = { dir } })
end

local function init()
  if vim.g.global_cd == nil then
    vim.g.global_cd = false
  end

  vim.api.nvim_create_user_command(
    'CD',
    'lua require("cdbuf").cd_to_buf(false, "<bang>")',
    { bang = true, force = true }
  )
  vim.api.nvim_create_user_command(
    'LCD',
    'lua require("cdbuf").cd_to_buf(true, "<bang>")',
    { bang = true, force = true }
  )
end

return {
  cd_to_buf = cd_to_buf,
  init = init,
}
