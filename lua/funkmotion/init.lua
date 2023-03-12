local q = require "vim.treesitter.query"

local M = {}

function M.get_nodes(bufnr)
	local filetype = vim.filetype.match({ buf = bufnr })
	local language_tree = vim.treesitter.get_parser(bufnr, filetype)
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()

	local query = vim.treesitter.parse_query(filetype, [[
    ;;query
	(function_declaration
      name: (identifier) @func.name)
	(method_declaration
      name: (field_identifier) @func.name)
]])
	local captured_nodes = {}
	local idx = 1
	for _, captures in query:iter_matches(root, bufnr) do
		local func_name = q.get_node_text(captures[1], bufnr)
		local ln, col = captures[1]:range()
		local pos = {}
		pos["line"] = ln
		pos["col"] = col
		captured_nodes[idx] = { func_name, pos }
		idx = idx + 1
	end
	return captured_nodes


end

return M
