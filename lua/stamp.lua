--[============================================================================[

Stamp

Creates a :Stamp [register] command that can be used to replace the word under
the cursor with whatever is in either the default register or the given
register. Does not modify the register it gets the value from.

I don't know where I got this from or if I wrote it. It's kind of been a while.
I know it is modified from what it originally was, so tracking it down is a
little difficult. Best guess I have is something off of the Vim wiki.
--]============================================================================]

local function stamp(register)
  if not register then
    register = vim.v.register
  end
  local v = vim.fn.getreg(register)
  vim.cmd { cmd = 'norm!', args = { 'viw"' .. register .. 'p' } }
  vim.fn.setreg(register, v)
end

local function callback()
  stamp(vim.v.register)
end

local function init(_options)
  vim.api.nvim_create_user_command(
    'Stamp',
    'lua require("stamp").stamp(vim.v.register)',
    { register = true }
  )
end

return {
  stamp = stamp,
  callback = callback,
  init = init,
}
