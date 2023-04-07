return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#282a36",
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     style = "night",
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  {
    "maxmx03/dracula.nvim",
    config = function()
      require("dracula").setup({
        transparent = true,
      })
    end,
  },
}
