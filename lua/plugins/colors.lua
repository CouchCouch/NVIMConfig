local everforest = {
    "sainnhe/everforest",
    config = function ()
        vim.g.everforest_enable_italic = 1
        vim.g.everforest_background = "medium"
        vim.g.everforest_transparent_background = 1
        vim.g.everforest_diagnostic_virtual_text = "highlighted"
        vim.cmd.colorscheme('everforest')
    end
}

local tokyonight = {
    "folke/tokyonight.nvim",
    config = function ()
        require("tokyonight").setup({
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        })
        vim.cmd.colorscheme('tokyonight')
    end
}

local gruvbox = {
    "sainnhe/gruvbox-material",
    config = function ()
        vim.g.gruvbox_material_background = "medium"
        vim.cmd.colorscheme('gruvbox-material')
    end,
}

local sonokai = {
    "sainnhe/sonokai",
    config = function ()
        vim.g.sonokai_style = "andromeda"
        vim.g.sonokai_enable_italic = 1
        vim.g.sonokai_transparent_background = 1
        vim.cmd.colorscheme('sonokai')
    end,
}

return everforest
