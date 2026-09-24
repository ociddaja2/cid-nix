-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.recipes.ai" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.completion.blink-copilot" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.colorscheme" },
  { import = "astrocommunity.scrolling.cinnamon-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },

  -- import/override with your plugins folder
}
