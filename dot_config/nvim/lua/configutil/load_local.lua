return function(mod)
	require(mod)
	pcall(require, "_local." .. mod)
end
