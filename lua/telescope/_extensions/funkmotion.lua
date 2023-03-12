local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local fm = require("funkmotion")

-- our picker function: funkmotion
local funkmotion = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "functions",
		finder = finders.new_table {
			results = fm.get_nodes(vim.api.nvim_get_current_buf()),
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry[1],
					ordinal = entry[1],
				}
			end
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				local line = selection.value[2].line + 1
				local col = selection.value[2].col + 1
				vim.api.nvim_win_set_cursor(0, { line, col })
			end)
			return true
		end,
	}):find()
end

return require("telescope").register_extension {
	exports = {
		funkmotion = funkmotion
	},
}
