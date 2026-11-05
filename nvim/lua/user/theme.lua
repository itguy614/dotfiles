-- Follows the theme manager (scripts/theme). It links the active theme into
-- ~/.local/state/themes/current and writes the colorscheme's name beside it:
--
--   neovim.colorscheme   name to pass to :colorscheme
--   neovim/              (optional) runtimepath dir that provides that scheme
--   theme                rewritten last on every switch, so its mtime says
--                        when the active theme changed
--
-- On Omarchy there is no state of our own: `theme export-omarchy` puts the same
-- files in the themes it hands to omarchy-theme-set, so this reads
-- ~/.local/state/omarchy/current/theme and watches theme.name for a switch.
-- A theme with no colorscheme (any stock Omarchy one) restores what the config
-- chose. With no state at all (`theme init` never ran) this does nothing and the
-- colorscheme set in plugins/nord-light-brighter.lua stays.
local M = {}

local state = vim.env.XDG_STATE_HOME or (vim.env.HOME .. '/.local/state')

-- The theme manager's state, else the theme Omarchy applied: the directory
-- holding the files, and the file whose mtime changes on every switch.
local function source()
    local own = state .. '/themes/current'
    if vim.uv.fs_stat(own .. '/theme') then return own, own .. '/theme' end
    local omarchy = state .. '/omarchy/current'
    if vim.uv.fs_stat(omarchy .. '/theme.name') then
        return omarchy .. '/theme', omarchy .. '/theme.name'
    end
end

local function read(dir, name)
    local f = io.open(dir .. '/' .. name)
    if not f then return nil end
    local line = f:read('*l')
    f:close()
    return line and vim.trim(line) or nil
end

local function stamp()
    local _, file = source()
    local st = file and vim.uv.fs_stat(file)
    return st and (st.mtime.sec * 1e9 + st.mtime.nsec) or nil
end

local applied

function M.apply()
    applied = stamp()
    local dir = source()
    if not dir then return end
    local scheme = read(dir, 'neovim.colorscheme')

    if M.rtp then vim.opt.rtp:remove(M.rtp) end
    M.rtp = nil

    if not scheme or scheme == '' then
        -- Nothing from this theme: go back to what the config chose, if we ever left it.
        if M.default then pcall(vim.cmd.colorscheme, M.default) end
        return
    end
    M.default = M.default or vim.g.colors_name

    -- Add the theme's own runtimepath, replacing the previous theme's.
    if vim.uv.fs_stat(dir .. '/neovim') then
        M.rtp = dir .. '/neovim'
        vim.opt.rtp:prepend(M.rtp)
    end

    if not pcall(vim.cmd.colorscheme, scheme) then
        vim.notify('theme: colorscheme "' .. scheme .. '" not found', vim.log.levels.WARN)
    end
end

function M.setup()
    M.apply()
    -- Running instances follow a `theme set` as soon as they regain focus.
    vim.api.nvim_create_autocmd({ 'FocusGained', 'VimResume' }, {
        group = vim.api.nvim_create_augroup('user_theme', { clear = true }),
        callback = function()
            if stamp() ~= applied then M.apply() end
        end,
    })
    vim.api.nvim_create_user_command('ThemeReload', M.apply, {})
end

return M
