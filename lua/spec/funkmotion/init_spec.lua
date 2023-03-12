local fm = require("funkmotion")

local function i(value)
	print(vim.inspect(value))
end

describe(
	"get nodes",
	function()
		it(
			"matches Go files",
			function()
				local expected_positions = {
					{ "main", {
						col = 5,
						line = 2
					} }, { "a", {
						col = 5,
						line = 5
					} }, { "b", {
						col = 5,
						line = 8
					} }, { "c", {
						col = 5,
						line = 11
					} }, { "doDummy", {
						col = 15,
						line = 17
					} }
				}

				local path = vim.loop.cwd() .. "/main.go"
				local bufnr = vim.uri_to_bufnr(vim.uri_from_fname(path))
				assert.are.same(fm.get_nodes(bufnr), expected_positions)
			end
		)
	end
)
