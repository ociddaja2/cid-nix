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

        -- MEMBUAT BACKGROUND TRANSPARAN: Komentar (--) di bawah ini dihapus
        for _, name in ipairs(vim.fn.getcompletion("", "highlight")) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
          if ok and hl and next(hl) ~= nil then
            ---@diagnostic disable-next-line: assign-type-mismatch
            hl.bg = "none"
            ---@diagnostic disable-next-line: assign-type-mismatch
            hl.ctermbg = "none"
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.api.nvim_set_hl(0, name, hl)
          end
        end

        -- restore the useful groups (selection, search, etc.)
        for name, hl in pairs(saved) do
          vim.api.nvim_set_hl(0, name, hl)
        end

        vim.api.nvim_set_hl(0, "Search", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "red", bg = "none" })
        vim.api.nvim_set_hl(0, "Substitute", { fg = "red", bg = "none" })
        -- Mencerahkan warna teks path/direktori
        vim.api.nvim_set_hl(0, "Directory", { fg = "#7aa2f7", bold = true }) -- Ubah warna sesuai selera, contoh: Biru terang
        -- Contoh untuk mencerahkan teks umum atau path
        vim.api.nvim_set_hl(0, "Special", { fg = "#bb9af7" })
        -- Tambahkan baris ini di dalam fungsi init = function() pada file astroui.lua Anda:

        vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#D3D3D3", bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "none" })
        vim.api.nvim_set_hl(0, "NonText", { fg = "#D3D3D3" })
        vim.api.nvim_set_hl(0, "Comment", { fg = "#a9b1d6" }) -- Mencerahkan warna teks yang biasanya redup
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
