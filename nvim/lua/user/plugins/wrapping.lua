return {
  'andrewferrier/wrapping.nvim',
  config = function()
    require("wrapping").setup({
      notify_on_switch = true,
      auto_set_mode_filetypelist = {
        "markdown",
        "text",
      },
    })
  end,
}
