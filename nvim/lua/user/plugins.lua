local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colors
    { import = 'user.plugins.tokyonight' },
    
    -- Indent autodetection with editorconfig support
    { 'tpope/vim-sleuth' },

    -- Commenting support
    { import = 'user.plugins.vim-commentary' },

    -- Jump to the last place we were in the file
    { 'farmergreg/vim-lastplace' },

    -- Enable * searching with visually selected text
    { 'nelstrom/vim-visual-star-search' },

    -- Automatically create parent dirs when saving
    { 'jessarcher/vim-heritage' },
    
    -- Automatically set the working directory to the project root
    { import = 'user.plugins.vim-router' },

    -- Automatically add closing brackets, quotes, etc.
    { 'windwp/nvim-autopairs', config = true },

    -- Add smooth scrolling to avoid jumps
    { 'karb94/neoscroll.nvim', config = true },

    -- Fix indentation when pasting code
    { import ="user.plugins.vim-pasta" },

    -- Fuzzy finder
    { import = "user.plugins.telescope" },

    -- A status line
    { import = "user.plugins.lualine" },

    -- File tree sidebar
    { import = "user.plugins.nvim-tree" },

    -- Display indentation lines
    { import = "user.plugins.indent-blankline" },

    -- GIT integration
    { 'tpope/vim-fugitive' },

    -- Display buffers as tabs
    { import = "user.plugins.bufferline" },

    -- Better integrated terminal
    { import = "user.plugins.floaterm" }
})
