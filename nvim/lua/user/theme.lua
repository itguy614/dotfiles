-- Follows the theme manager (scripts/theme). It links the active theme into
-- ~/.local/state/themes/current and writes the colorscheme's name beside it:
--
--   neovim.colorscheme   name to pass to :colorscheme
--   neovim/              (optional) runtimepath dir that provides that scheme
--   theme                rewritten last on every switch, so its mtime says
--                        when the active theme changed
--
-- With no state (Omarchy, or `theme init` never ran) this does nothing and the
-- colorscheme set in plugins/nord-light-brighter.lua stays.
local M = {}

local dir = (vim.env.XDG_STATE_HOME or (vim.env.HOME .. '/.local/state'))
    .. '/themes/current'

local function read(name)
    local f = io.open(dir .. '/' .. name)
    if not f then return nil end
    local line = f:read('*l')
    f:close()
    return line and vim.trim(line) or nil
end

local function stamp()
    local st = vim.uv.fs_stat(dir .. '/theme')
    return st and (st.mtime.sec * 1e9 + st.mtime.nsec) or nil
end

local applied

function M.apply()
    applied = stamp()
    local scheme = read('neovim.colorscheme')
    if not scheme or scheme == '' then return end

    -- Add the theme's own runtimepath, replacing the previous theme's.
    if M.rtp then vim.opt.rtp:remove(M.rtp) end
    M.rtp = nil
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
