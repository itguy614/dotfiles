-- Nord Light Brighter palette, lifted verbatim from the upstream colorscheme
-- (huytd/vim-nord-light-brighter, colors/nord-light-brighter.vim).
--
-- Kept in its own module so the colorscheme overrides and any plugin that
-- needs to hand-roll highlights work from one source of truth.
return {
    bg        = '#ffffff',
    fg        = '#24292e',
    fg3       = '#474b4f',
    fg4       = '#595c60',
    bg2       = '#ebebeb',
    bg3       = '#d6d6d6',
    bg4       = '#c2c2c2',
    comment   = '#8995a0',
    const     = '#1155a3',
    func      = '#0d5c43',
    str       = '#50750e',
    type      = '#a74047',
    warning   = '#f93232',
    warning2  = '#e36209',

    -- Not upstream: editor.selectionBackground from the matching VS Code theme
    -- (huytd/vscode-nord-light), flattened onto white.
    selection = '#c2d9f5',
    -- Upstream uses #d1d1d1 for LineNr, which is unreadable on bg2.
    gutter_fg = '#b5bcc4',
}
