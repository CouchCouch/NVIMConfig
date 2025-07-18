require("ryan.set")
vim.lsp.set_log_level("debug")
require("ryan.remap")
require("ryan.lazy_init")


local augroup = vim.api.nvim_create_augroup
local ryanGroup = augroup('ryan', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ryanGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
    group = ryanGroup,
    callback = function()
        vim.cmd.colorscheme("everforest")
        --vim.cmd.colorscheme("tokyonight")
    end
})

autocmd('LspAttach', {
    group = ryanGroup,
    callback = function()
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
