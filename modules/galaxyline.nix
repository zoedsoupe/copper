{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [
      galaxyline-nvim
      nvim-web-devicons
    ];

    vim.luaConfigRC = ''
      local gl = require('galaxyline')

      local condition = require('galaxyline.condition')
      local gls = gl.section

      gl.short_line_list = {'NvimTree','vista','dbui'}

      local colors = require('galaxyline.theme').default

      local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
          return true
        end
        return false
      end

      local mode_colors = {
         ["n"] = { "NORMAL", colors.red },
         ["no"] = { "N-PENDING", colors.red },
         ["i"] = { "INSERT", colors.violet },
         ["ic"] = { "INSERT", colors.violet },
         ["t"] = { "TERMINAL", colors.green },
         ["v"] = { "VISUAL", colors.cyan },
         ["V"] = { "V-LINE", colors.cyan },
         [""] = { "V-BLOCK", colors.cyan },
         ["R"] = { "REPLACE", colors.orange },
         ["Rv"] = { "V-REPLACE", colors.orange },
         ["s"] = { "SELECT", colors.darkblue },
         ["S"] = { "S-LINE", colors.darkblue },
         [""] = { "S-BLOCK", colors.darkblue },
         ["c"] = { "COMMAND", colors.red },
         ["cv"] = { "COMMAND", colors.red },
         ["ce"] = { "COMMAND", colors.red },
         ["r"] = { "PROMPT", colors.cyan },
         ["rm"] = { "MORE", colors.cyan },
         ["r?"] = { "CONFIRM", colors.cyan },
         ["!"] = { "SHELL", colors.green },
      }

      local mode = function(n)
         return mode_colors[vim.fn.mode()][n]
      end

      table.insert(gls.left, {
        ViMode = {
          provider = function()
            vim.cmd("hi GalaxyViMode guifg=" .. mode(2))
            return "▊"
          end,
          highlight = { "GalaxyViMode", colors.lightbg }
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
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.orange, colors.bg }
        },
      })

      table.insert(gls.left, {
        GitBranch = {
          provider = "GitBranch",
          condition = condition.check_git_workspace,
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.fg, colors.bg }
        },
      })

      table.insert(gls.left, {
        DiffAdd = {
          provider = "DiffAdd",
          condition = condition.hide_in_width,
          icon = "  ",
          highlight = { colors.green, colors.bg},
        },
      })

      table.insert(gls.left, {
        DiffModified = {
          provider = "DiffModified",
          condition = condition.hide_in_width,
          icon = " 柳",
          highlight = { colors.blue, colors.bg },
        },
      })

      table.insert(gls.left, {
        DiffRemove = {
          provider = "DiffRemove",
          condition = condition.hide_in_width,
          icon = "  ",
          highlight = { colors.red, colors.bg },
        },
      })

      table.insert(gls.left, {
        Filler = {
          provider = function()
            return " "
          end,
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.right, {
        LineInfo = {
          provider = "LineColumn",
          separator = "  ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.right, {
        PerCent = {
          provider = "LinePercent",
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
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
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg},
        },
      })

      table.insert(gls.right, {
        BufferType = {
          provider = "FileTypeName",
          condition = condition.hide_in_width,
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.right, {
        FileEncode = {
          provider = "FileEncode",
          condition = condition.hide_in_width,
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.right, {
        Space = {
          provider = function()
            return " "
          end,
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.short_line_left, {
        BufferType = {
          provider = "FileTypeName",
          separator = " ",
          separator_highlight = { colors.bg, colors.bg },
          highlight = { colors.white, colors.bg },
        },
      })

      table.insert(gls.short_line_left, {
        SFileName = {
          provider = "SFileName",
          condition = condition.buffer_not_empty,
          highlight = { colors.white, colors.bg },
        },
      })
    '';
  };
}
