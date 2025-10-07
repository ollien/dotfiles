return {
	"nvim-tree/nvim-tree.lua",
	opts = {
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
		view = {
			number = false,
			relativenumber = true,
			float = {
				enable = true,
				-- Taken from
				-- https://github.com/MarioCarrion/videos/blob/269956e913b76e6bb4ed790e4b5d25255cb1db4f/2023/01/nvim/lua/plugins/nvim-tree.lua
				open_win_config = function()
					local HEIGHT_RATIO = 0.8
					local WIDTH_RATIO = 0.5

					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = screen_h * HEIGHT_RATIO
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					return {
						border = "rounded",
						relative = "editor",
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
					}
				end,
			},
		},
		git = {
			ignore = false,
		},
	},
}

-- License for above snippet
--
-- MIT License
--
-- Copyright (c) 2020 Mario Carrion
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
