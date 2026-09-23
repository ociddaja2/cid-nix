-- local copilot = require "plugins.copilot"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
      "zbirenbaum/copilot.lua",
      "giuxtaposition/blink-cmp-copilot",
    },
    -- build = function() require("blink.cmp").build():pwait() end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default" },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      -- ghost_text = {
      --   enabled = true,
      -- },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
        appereance = {
          kind_icons = {
            Copilot = "",
            Text = "󰉿",
            Method = "󰊕",
            Function = "󰊕",
            Constructor = "󰒓",

            Field = "󰜢",
            Variable = "󰆦",
            Property = "󰖷",

            Class = "󱡠",
            Interface = "󱡠",
            Struct = "󱡠",
            Module = "󰅩",

            Unit = "󰪚",
            Value = "󰦨",
            Enum = "󰦨",
            EnumMember = "󰦨",

            Keyword = "󰻾",
            Constant = "󰏿",

            Snippet = "󱄽",
            Color = "󰏘",
            File = "󰈔",
            Reference = "󰬲",
            Folder = "󰉋",
            Event = "󱐋",
            Operator = "󰪚",
            TypeParameter = "󰬛",
          },
        },
      },

      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
        },
      },
      fuzzy = { implementation = "rust" },
    },
  },
}
