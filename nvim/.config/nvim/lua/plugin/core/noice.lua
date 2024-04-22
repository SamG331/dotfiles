local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        -- `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
}


vim.opt.shortmess:append 's' -- removes the "search hit BOTTOM continuing at TOP" message for search

function M.config()
    require("noice").setup {
        cmdline = {
            view = "cmdline",
            format = {
                cmdline = { icon = " " },
                search_up = { icon = " " },
                search_down = { icon = " " },
                filter = { icon = " " },
                help = { icon = " " },
                lua = { icon = " " },
            },
        },
        messages = {
            enabled = true,
        },
        popupmenu = {
            enabled = true,
        },
        notify = {
            enabled = false, -- noice still uses nvim-notify for it's own messages
        },
        smart_move = {
            enabled = false,
        },
        lsp = {
            progress = {
                enabled = false,
            },
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        routes = {
            -- Remove notification for writing, deletion, and undo/redo operations
            {
                filter = {
                    event = "msg_show",
                    -- kind will remove all empty message kinds
                    -- kind = ""
                    any = {
                        { find = "written" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "%d fewer lines" },
                        { find = "%d more lines" },
                    }
                },
                opts = { skip = true },
            },
        }
    }

    -- needed if notify is used for transparent background
    ---@diagnostic disable-next-line: missing-fields
    require("notify").setup {
        background_colour = "#000000",
        stages = "no_animation"
    }
end

return M
