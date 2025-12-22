local make_bold = function(name)
	local value = vim.api.nvim_get_hl(0, { name = name })
	value.bold = true
	vim.api.nvim_set_hl(0, name, value)
end

local make_italic = function(name)
	local value = vim.api.nvim_get_hl(0, { name = name })
	value.italic = true
	vim.api.nvim_set_hl(0, name, value)
end

vim.cmd.colorscheme("lackluster-hack")
-- call make_bold and make_italic after setting the colorscheme
make_bold("@keyword")
make_italic("@keyword")
