local winbar_settings = {
    lualine_a = {
        { "filetype", icon_only = true, colored = false },
        {
            "filename",
            newfile_status = true,
            path = 1,
            shorting_target = 40,
            symbols = {
                modified = " ",
                readonly = " ",
            },
        },
    },
    lualine_b = {
        "diff",
        "diagnostics",
    },
    lualine_c = {
        "navic",
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic",
    },
    config = function()
        require("nvim-navic").setup({
            depth_limit = 4,
            click = true,
            safe_output = true,
            lsp = {
                auto_attach = true,
            }
        })
        require("lualine").setup({
            options = {
                theme = "auto",
                globalstatus = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "buffers",
                        show_filename_only = false,
                        mode = 2,
                        buffers_color = {
                            active = "lualine_c_insert",
                        },
                        symbols = {
                            alternate_file = "",
                        }
                    }
                },
                lualine_x = { "overseer" },
                lualine_y = { "progress", "searchcount" },
                lualine_z = { "location" },
            },
            winbar = vim.tbl_extend("keep", winbar_settings, {
                lualine_y = { "progress", "searchcount" },
                lualine_z = { "location" },
            }),
            inactive_winbar = winbar_settings,
        })
    end
}
