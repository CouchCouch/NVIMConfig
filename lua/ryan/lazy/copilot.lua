return {
    "zbirenbaum/copilot.lua",
    dependencies = {
        "zbirenbaum/copilot-cmp",
    },
    config = function ()
        require("copilot").setup{
            cmd = "Copilot",
            build = ":Copilot auth",
            event = "BufReadPost",
            opts = {
                suggestion = {
                    enabled = not vim.g.ai_cmp,
                    auto_trigger = true,
                    hide_during_completion = vim.g.ai_cmp,
                    keymap = {
                        accept = false, -- handled by nvim-cmp / blink.cmp
                        next = "<M-]>",
                        prev = "<M-[>",
                    },
                },
                panel = { enabled = false },
                filetypes = {
                    markdown = true,
                    help = true,
                },
            },
        }
        require("copilot_cmp").setup()
    end,
}
