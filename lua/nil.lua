local M = {}

function M.init(options)
	if options == nil then
		options = {}
	end
	require('stripws').init(options)
	require('cdbuf').init(options)
	require('stamp').init(options)
end

return M
