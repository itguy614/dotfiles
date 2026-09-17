-- Nord Light Brighter (huytd/vim-nord-light-brighter)
--
-- The upstream colorscheme is a vimscript file that only defines legacy syntax
-- groups, so a handful of modern Neovim groups fall through to the built-in
-- light defaults. The overrides below fill those in from the theme's own
-- palette rather than letting Neovim guess.

local c = require('user.palette')

local function overrides()
    local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

    -- Statusline / tabline: upstream defines StatusLine only
    hl('StatusLine',   { fg = c.fg3,     bg = c.bg2 })
    hl('StatusLineNC', { fg = c.comment, bg = c.bg2 })
    hl('TabLine',      { fg = c.fg4,     bg = c.bg2 })
    hl('TabLineFill',  {                 bg = c.bg2 })
    hl('TabLineSel',   { fg = c.fg,      bg = c.bg, bold = true })
    hl('WinBar',       { fg = c.fg3,     bg = c.bg })
    hl('WinBarNC',     { fg = c.comment, bg = c.bg })
    hl('WinSeparator', { fg = c.bg3 })

    -- Selection: upstream leaves Visual to the Neovim default grey
    hl('Visual', { bg = c.selection })

    -- Uniform gutter. Upstream gives LineNr a bg2 background but leaves
    -- SignColumn transparent, which splits the gutter into two tones.
    hl('LineNr',       { fg = c.gutter_fg, bg = c.bg2 })
    hl('SignColumn',   {                   bg = c.bg2 })
    hl('CursorLineNr', { fg = c.str,       bg = c.bg2, bold = true })
    hl('FoldColumn',   { fg = c.comment,   bg = c.bg2 })

    -- Spell: upstream defines none, so Neovim's dark red undercurl shows up
    -- everywhere (spell is enabled globally in options.lua).
    for _, g in ipairs({ 'SpellBad', 'SpellCap', 'SpellRare', 'SpellLocal' }) do
        hl(g, { undercurl = true, sp = c.bg4 })
    end

    -- Diagnostics, mapped onto the palette instead of Neovim's defaults
    hl('DiagnosticError', { fg = c.warning })
    hl('DiagnosticWarn',  { fg = c.warning2 })
    hl('DiagnosticInfo',  { fg = c.const })
    hl('DiagnosticHint',  { fg = c.func })

    -- Treesitter / LSP gaps. Module paths link to Type upstream and come out
    -- red; the theme renders them as plain foreground.
    hl('@module',              { fg = c.fg })
    hl('@lsp.type.namespace',  { fg = c.fg })
    hl('@type.builtin',        { fg = c.type })
end

return {
    "huytd/vim-nord-light-brighter",
    lazy = false,
    priority = 1000,
    config = function()
        vim.opt.background = 'light'
        vim.cmd('colorscheme nord-light-brighter')
        overrides()
        -- Re-apply if anything reloads the colorscheme later
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = 'nord-light-brighter',
            callback = overrides,
        })
    end,
}
