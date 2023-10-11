return {
  'voldikss/vim-floaterm',
  keys = {
    { '<F1>', ':FloatermToggle<CR>' },
    { '<F1>', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
  },
  init = function()
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    -- vim.g.floaterm_wintype = 'split'
  end,
  config = true,
}
