local function switch_to_buffer_window(buf)
	local wins = vim.fn.win_findbuf(buf)
	if #wins > 0 then
		vim.api.nvim_set_current_win(wins[1])
		return true
	else
		return false
	end
end

local function toggle_grug_far()
	local grug_far = require("grug-far")
	local grug_far_instances = require("grug-far.instances")

	local instance = grug_far_instances.get_instance(nil)
	if instance then
		instance:close()
	else
		grug_far.open()
	end
end

local function find_or_open_grug_far_with_term(term)
	local grug_far = require("grug-far")
	local grug_far_instances = require("grug-far.instances")

	local instance = grug_far_instances.get_instance(nil)
	if instance then
		instance:update_input_values({ search = term }, false)
		switch_to_buffer_window(instance:get_buf())
		vim.schedule(function()
			instance:goto_first_input()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", false)
		end)
	else
		grug_far.open({ prefills = { search = term } })
		vim.schedule(function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", false)
		end)
	end
end

local function find_or_open_grug_far_with_current_word()
	find_or_open_grug_far_with_term(vim.fn.expand("<cword>"))
end

return {
	cmd = "GrugFar",
	keys = {
		{
			"<leader>fw",
			function()
				toggle_grug_far()
			end,
			desc = "find and replace",
		},
		{
			"<leader>f*",
			function()
				find_or_open_grug_far_with_current_word()
			end,
			desc = "find and replace current word",
		},
	},
	opts = {
		showCompactInputs = true,
		transient = true,
		wrap = false,
		windowCreationCommand = "botright vsplit | vertical resize 50% | lua vim.wo.statuscolumn = '%s %{v:relnum == 0 ? \" \" : v:relnum} '",
		prefills = {
			flags = "-i",
		},
	},
	config = function(_, opts)
		require("grug-far").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "grug-far",
			callback = function()
				vim.opt_local.list = false
			end,
		})
	end,
}
