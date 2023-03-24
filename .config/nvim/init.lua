-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.10)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(0.90)
end)
