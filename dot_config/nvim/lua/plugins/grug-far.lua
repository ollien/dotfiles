return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {
		showCompactInputs = true,
		transient = true,
		wrap = false,
		windowCreationCommand = "botright vsplit | vertical resize 50% | lua vim.wo.statuscolumn = '%s %{v:relnum == 0 ? \" \" : v:relnum} '",
	},
}
