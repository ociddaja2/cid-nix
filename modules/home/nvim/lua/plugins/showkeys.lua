---@type LazySpec
return {
  {
    "nvzone/showkeys",
    lazy = false,
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "top-right",
      -- more opts
    },
    config = function(_, opts)
      require("showkeys").setup(opts)
      vim.cmd "ShowkeysToggle"
    end,
  },
}
