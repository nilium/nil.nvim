local function stamp(register)
  if not register then
    register = vim.v.register
  end
  local v = vim.fn.getreg(register)
  vim.fn.execute('norm! viw"' .. register .. 'p')
  vim.fn.setreg(register, v)
end

local function callback()
  stamp(vim.v.register)
end

local function bind(mode, lhs)
  vim.api.nvim_set_keymap(mode, lhs, "", { callback = callback })
end

local function setup(opts)
  vim.api.nvim_create_user_command(
    'Stamp',
    'lua require("stamp").stamp("<register>")',
    { register = true }
  )
end

return {
  stamp = stamp,
  callback = callback,
  bind = bind,
  setup = setup,
}
