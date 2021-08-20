local gl = require('galaxyline')

local condition = require('galaxyline.condition')
local gls = gl.section

gl.short_line_list = {'NvimTree','vista','dbui'}

local global_theme = "themes/" .. "onedark"
local colors = require(global_theme)

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local mode_colors = {
   [110] = { "NORMAL", colors.red },
   [105] = { "INSERT", colors.dark_purple },
   [99] = { "COMMAND", colors.pink },
   [116] = { "TERMINAL", colors.green },
   [118] = { "VISUAL", colors.cyan },
   [22] = { "V-BLOCK", colors.cyan },
   [86] = { "V_LINE", colors.cyan },
   [82] = { "REPLACE", colors.orange },
   [115] = { "SELECT", colors.nord_blue },
   [83] = { "S-LINE", colors.nord_blue },
}

local mode = function(n)
   return mode_colors[vim.fn.mode():byte()][n]
end

table.insert(gls.left, {
  ViMode = {
    provider = function()
      vim.cmd("hi GalaxyViMode guifg=" .. mode(2))
      return "▊"
    end,
    separator_highlight = { "NONE", colors.one_bg2 },
    highlight = { "NONE", colors.lightbg }
  },
})
-- print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, "ts")

table.insert(gls.left, {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.orange, colors.alt_bg },
  },
})

table.insert(gls.left, {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.left, {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.green, colors.alt_bg },
  },
})

table.insert(gls.left, {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " 柳",
    highlight = { colors.blue, colors.alt_bg },
  },
})

table.insert(gls.left, {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.red, colors.alt_bg },
  },
})

table.insert(gls.left, {
  Filler = {
    provider = function()
      return " "
    end,
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  LineInfo = {
    provider = "LineColumn",
    separator = "  ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  Tabstop = {
    provider = function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  BufferType = {
    provider = "FileTypeName",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  Space = {
    provider = function()
      return " "
    end,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.alt_bg, colors.alt_bg },
  },
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.alt_bg, colors.alt_bg },
  },
})
