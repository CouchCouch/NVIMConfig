return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                --icons = false,
                modes = {
                    my_diagnostics = {
                        mode = 'diagnostics',
                        filter = {
                            severity = {
                                vim.diagnostic.severity.ERROR,
                            },
                        }
                    },
                }
            })
-- a run on sentence with a non capitalized first word for testing
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle('diagnostics')
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end)

        end
    },
}
