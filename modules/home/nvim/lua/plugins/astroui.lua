---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      astrodark = {
        SnacksDashboardHeader = { fg = "#ffffff", bold = true }, -- white
        SnacksDashboardDesc = { fg = "#ffffff" },
        SnacksDashboardIcon = { fg = "#ffffff" },
        SnacksDashboardFooter = { fg = "#ffffff" },
      },
      init = function()
        -- highlight groups we want to KEEP as-is (including their bg)
        local keep_names = {
          "Visual",
          "VisualNOS",
          "ColorColumn",
          "PmenuSel",
          "MatchParen",
          "QuickFixLine",
        }

        -- save their original definitions
        local saved = {}
        for _, name in ipairs(keep_names) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
          if ok and hl and next(hl) ~= nil then saved[name] = hl end
        end

        -- make ALL highlight groups transparent (bg only) -- command if you didnt like transparent bg
        -- for _, name in ipairs(vim.fn.getcompletion("", "highlight")) do
        --   local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        --   if ok and hl and next(hl) ~= nil then
        --     ---@diagnostic disable-next-line: assign-type-mismatch
        --     hl.bg = "none"
        --     ---@diagnostic disable-next-line: assign-type-mismatch
        --     hl.ctermbg = "none"
        --     ---@diagnostic disable-next-line: param-type-mismatch
        --     vim.api.nvim_set_hl(0, name, hl)
        --   end
        -- end

        -- restore the useful groups (selection, search, etc.)
        for name, hl in pairs(saved) do
          vim.api.nvim_set_hl(0, name, hl)
        end

        vim.api.nvim_set_hl(0, "Search", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "Substitute", { fg = "red", bg = "none" })
        -- Spectre Highlighting (Tokyonight tuned)
        vim.api.nvim_set_hl(0, "SpectreSearch", { fg = "#e0af68", bg = "none" }) -- yellow
        vim.api.nvim_set_hl(0, "SpectreReplace", { fg = "#f7768e", bg = "none" }) -- soft red
        vim.api.nvim_set_hl(0, "SpectreReplaceWord", { fg = "#f7768e", bg = "none" }) -- soft red

        vim.api.nvim_set_hl(0, "SpectreAdd", { fg = "#9ece6a", bg = "none" }) -- green
        vim.api.nvim_set_hl(0, "SpectreDelete", { fg = "#ff9e64", bg = "none" }) -- orange (better contrast)
        vim.api.nvim_set_hl(0, "SpectreChange", { fg = "#7aa2f7", bg = "none" }) -- blue
        return {}
      end,
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
