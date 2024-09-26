return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function(plugin, opts)
        require("catppuccin").setup({
            theme = 'catppuccin-frappe',
            -- Integrations
            barbecue = {
                dim_dirname = true, -- directory name is dimmed by default
                bold_basename = true,
                dim_context = false,
                alt_background = false,
            },
            gitsigns = true,
            indent_blankline = {
                enabled = true,
                scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            },
            nvimtree = true,
            treesitter = true,
            telescope = {
                enabled = true,
                -- style = "nvchad"
            }
        })
        vim.cmd('colorscheme catppuccin-frappe')
    end,
}
