return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettierd,
        },
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  },
}
