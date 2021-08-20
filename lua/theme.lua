local global_theme = vim.g.theme
local present, base16 = pcall(require, "base16")

if present then
   base16(base16.themes(global_theme), true)
   require("highlights")
   return true
else
   return false
end
