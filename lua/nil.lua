local M = {}

function M.setup(options)
	if options == nil then
		options = {}
	end
	require('stripws').setup(options)
	require('cdbuf').setup(options)
	require('stamp').setup(options)
end

M.init = M.setup -- Deprecated.

return M
