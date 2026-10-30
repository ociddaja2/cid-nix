---@type LazySpec
return {
  {
    "vyfor/cord.nvim",
    opts = {
      editor = {
        client = "1562023266858705017",
        -- client = "neovim",
        icon = "https://c.tenor.com/Dv5mWY04msgAAAAC/tenor.gif",
        tooltip = "A Text Editor :3",
      },
      display = {
        -- view = "editor",
        theme = "default",
        flavor = "accent",
        layout = "editor",
        swap_icons = true,
        swap_fields = true,
      },
      idle = {
        details = function(opts) return "Break from " .. opts.workspace end,
        state = "java.lang.NullPointerException: Parameter specified as non-null is null",
        timeout = 180000, -- 3 min /180k ms
        tooltip = "Turu 😪",
      },
      timestamp = {
        shared = true,
      },
    },
  },
}
