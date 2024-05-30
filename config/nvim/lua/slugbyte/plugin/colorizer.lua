-- "https://github.com/norcalli/nvim-colorizer.lua"
return {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    priority = 1000,
    config = function()
        require('colorizer').setup()
    end
}
