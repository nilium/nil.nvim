--[============================================================================[
cdbuf.vim
Noel Cower

Plugin to CD to the directory of the current window / buffer.

Can be configured via `require("cdbuf").setup { always_global = true }` to
always change the process directory instead of the window diretory.

Commands:

  :CD[!] - Change directories to the buffer's directory. By default, this is
  local to the window unless cdbuf is configured with always_global set to
  true. If the bang (:CD!) is given, ignore always_global and only affect the
  current window.

  :LCD - Change the window's directory to the buffer's directory.

  :GCD - Change the process's directory to the buffer's directory.
--]============================================================================]

local always_global = false

local function cd_to_buf(force_scope)
	local cmd = 'lchdir'
	if force_scope == 'global' then
		cmd = 'chdir'
	elseif force_scope == 'local' or force_scope == '!' then
		cmd = 'lchdir'
	elseif type(force_scope) == 'string' and force_scope ~= "" then
		error("Invalid cd_to_buf(force_scope = " .. force_scope .. "): may only be global or local")
	elseif always_global then
		cmd = 'chdir'
	end
	local dir = vim.fn.expand('%:p:h')
	vim.cmd { cmd = cmd, args = { dir } }
end

local function setup(_options)
	if vim.g.global_cd == nil then
		vim.g.global_cd = false
	end

	vim.api.nvim_create_user_command(
		'CD',
		'lua require("cdbuf").cd_to_buf("<bang>")',
		{ bang = true, force = true }
	)
	vim.api.nvim_create_user_command(
		'LCD',
		'lua require("cdbuf").cd_to_buf("local")',
		{ force = true }
	)
	vim.api.nvim_create_user_command(
		'GCD',
		'lua require("cdbuf").cd_to_buf("global")',
		{ force = true }
	)
end

return {
	cd_to_buf = cd_to_buf,
	setup = setup,
	init = setup, -- Deprecated.
}
