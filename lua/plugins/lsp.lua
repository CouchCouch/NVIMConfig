return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        {
            "neovim/nvim-lspconfig",
        },
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" },

        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "saadparwaiz1/cmp_luasnip" },
        { "j-hui/fidget.nvim" },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        }
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.setloclist() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
            vim.keymap.set("n", "<leader>I", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, vim.tbl_deep_extend("force", opts, { desc = "Toggle Inlay Hints" }))
        end)

        local cmp = require('cmp')
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "lua_ls",
                "jdtls",
                "clangd",
                "eslint",
                "cmake",
                "harper_ls",
                "pylsp",
                "html",
                "gopls",
                "tailwindcss"
            },
            handlers = {
                --lsp.default_setup,
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                                hint = {
                                    enable = true,
                                    libraries = { "vim", "busted" },
                                },
                            }
                        }
                    }
                end,
                ['gopls'] = function()
                    require("lspconfig").gopls.setup {
                        settings = {
                            gopls = {
                                gofumpt = true,
                                staticcheck = true,
                                completeUnimported = true,
                                usePlaceholders = true,
                                analyses = {
                                    unusedparams = true,
                                },
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    parameterNames = true,
                                    variableTypes = true,
                                    functionTypeParameters = true,
                                    rangeVariableTypes = true,
                                },
                            }
                        }
                    }
                end,
                ['ts_ls'] = function ()
                    require("lspconfig").ts_ls.setup {
                        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
                        settings = {
                            tsserver = {
                                filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
                                format = { enable = false },
                                importModuleSpecifierPreference = "project-relative",
                            }
                        }
                    }
                end,
                ["clangd"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup{
                        root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", "."),
                    }
                end,

                ["harper_ls"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.harper_ls.setup{
                        settings = {
                            ["harper-ls"] = {
                                linters = {
                                    SentenceCapitalization = false,
                                    LongSentences = false,
                                },
                                diagnosticSeverity = "hint",
                            }
                        }
                    }
                end,
            }
        })

        local cmp_action = require('lsp-zero').cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                ["<Tab>"] = cmp_action.luasnip_supertab(),
                ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
            }),
            sources = cmp.config.sources({
                { name = 'copilot' },
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'path', keyword_length = 3 },
                { name = 'buffer' },
            }),
        })

        vim.diagnostic.config({
            ignore = { "harper_ls" },
            update_in_insert = false,
            underline = true,
            virtual_text = {
                source = "if_many",
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '⚠',
                    [vim.diagnostic.severity.HINT] = '',
                    [vim.diagnostic.severity.INFO] = '󰋼',
                },
            },
            severity_sort = true,
        })
    end
}
