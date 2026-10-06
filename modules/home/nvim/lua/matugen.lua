 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#11140d',
    base01 = '#1d2119',
    base02 = '#282b23',
    base03 = '#8d9381',
    base04 = '#c3c9b5',
    base05 = '#e1e4d7',
    base06 = '#e1e4d7',
    base07 = '#e1e4d7',
    base08 = '#ffb4ab',
    base09 = '#46dfa7',
    base0A = '#b6cf98',
    base0B = '#a0d662',
    base0C = '#46dfa7',
    base0D = '#a0d662',
    base0E = '#b6cf98',
    base0F = '#d2ebb2',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e1e4d7',          bg = '#11140d' })
  hi('TelescopeBorder',         { fg = '#8d9381',             bg = '#11140d' })
  hi('TelescopePromptNormal',   { fg = '#e1e4d7',          bg = '#11140d' })
  hi('TelescopePromptBorder',   { fg = '#8d9381',             bg = '#11140d' })
  hi('TelescopePromptPrefix',   { fg = '#a0d662',             bg = '#11140d' })
  hi('TelescopePromptCounter',  { fg = '#c3c9b5',  bg = '#11140d' })
  hi('TelescopePromptTitle',    { fg = '#11140d',             bg = '#a0d662' })
  hi('TelescopePreviewTitle',   { fg = '#11140d',             bg = '#b6cf98' })
  hi('TelescopeResultsTitle',   { fg = '#11140d',             bg = '#46dfa7' })
  hi('TelescopeSelection',      { fg = '#e1e4d7',          bg = '#282b23' })
  hi('TelescopeSelectionCaret', { fg = '#a0d662',             bg = '#282b23' })
  hi('TelescopeMatching',       { fg = '#a0d662',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e1e4d7',          bg = '#11140d' })
  hi('MiniPickBorder',         { fg = '#8d9381',             bg = '#11140d' })
  hi('MiniPickPrompt',   { fg = '#e1e4d7',          bg = '#11140d' })
  hi('MiniPickPromptPrefix',   { fg = '#a0d662',             bg = '#11140d' })
  hi('MiniPickBorderText',    { fg = '#11140d',             bg = '#a0d662' })
  hi('MiniPickMatchCurrent',      { fg = '#e1e4d7',          bg = '#282b23' })
  hi('MiniPickPromptCaret', { fg = '#a0d662',             bg = '#282b23' })
  hi('MiniPickMatchRanges',       { fg = '#a0d662',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
