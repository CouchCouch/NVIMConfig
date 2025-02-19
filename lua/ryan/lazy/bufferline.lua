return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function ()
        require("bufferline").setup{
            options = {
                modified_icon = '🔥',
                indicator = {
                    icon = '🖐️',
                    style = "icon"
                },
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function (count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " ".. icon .. count
                end
            }
        }

        vim.keymap.set("n", "<TAB>", ":bn<CR>")
        vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
        --vim.keymap.set("i", "<C-TAB>", ":bn<CR>")
        --vim.keymap.set("i", "<C-S-TAB>", ":bp<CR>")
    end
}
