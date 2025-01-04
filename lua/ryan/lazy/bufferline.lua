return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function ()
        require("bufferline").setup{
            options = {
                indicator = {
                    icon = '🔥',
                    style = "icon"
                },
                color_icons = true,

            }
        }

        vim.keymap.set("n", "<TAB>", ":bn<CR>")
        vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
        vim.keymap.set("i", "<C-TAB>", ":bn<CR>")
        vim.keymap.set("i", "<C-S-TAB>", ":bp<CR>")
    end
}
