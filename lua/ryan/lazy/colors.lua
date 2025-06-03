function TransBG()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local tokyo = {
    'folke/tokyonight.nvim',
    config = function ()
        require("tokyonight").setup({
            style = "s",
            --transparent = "true"
        })
    end
}

local forest = {
    "sainnhe/everforest",
    config = function ()
        vim.g.everforest_enable_italic = true
        vim.g.everforest_transparent_background = 1
        vim.cmd.colorscheme('everforest')
        --TransBG()
    end
}

return forest
