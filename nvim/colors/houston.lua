-- houston.lua — Houston, the official Astro theme.
-- Ported from withastro/houston-vscode, themes/houston.json (253 UI keys,
-- 244 token rules), so every colour below is the source theme's own.
--
-- Activate with `:colorscheme houston`.

vim.cmd.highlight 'clear'
if vim.fn.exists 'syntax_on' then vim.cmd.syntax 'reset' end
vim.o.background = 'dark'
vim.g.colors_name = 'houston'

local c = {
  bg0 = '#17191e', -- editor.background
  bg1 = '#23262d', -- sideBar, panel, lineHighlight, inactive tab
  bg2 = '#343841', -- editorWidget.background, list.hoverBackground
  bg3 = '#2d4860', -- list.activeSelectionBackground

  fg = '#eef0f9', -- editor.foreground
  fg_dim = '#bfc1c9', -- sideBar.foreground
  gray = '#858b98', -- lineNumber.activeForeground
  comment = '#545864', -- comment, lineNumber, ansiBrightBlack

  blue = '#54b9ff', -- keyword, storage, tag, info
  mint = '#4bf3c8', -- variable, attribute, git added
  sand = '#ffd493', -- string, number, git modified
  peri = '#acafff', -- type, class
  cyan = '#00daef', -- function, focusBorder
  magenta = '#cc75f4', -- ansiBrightMagenta
  pink = '#f4587e', -- editorError.foreground
  red = '#dc3657', -- ansiRed
  yellow = '#fbc23b', -- editorWarning.foreground
  orange = '#ff8551', -- notificationsWarningIcon
  statusbar = '#17548b', -- statusBar.background
}

local function hi(g, s) vim.api.nvim_set_hl(0, g, s) end

-- ── Editor ──────────────────────────────────────────────────────────
hi('Normal', { fg = c.fg, bg = c.bg0 })
hi('NormalNC', { fg = c.fg, bg = c.bg0 })
hi('NormalFloat', { fg = c.fg, bg = c.bg2 })
hi('FloatBorder', { fg = c.cyan, bg = c.bg2 })
hi('FloatTitle', { fg = c.fg, bg = c.bg2, bold = true })
hi('CursorLine', { bg = c.bg1 })
hi('CursorColumn', { bg = c.bg1 })
hi('ColorColumn', { bg = c.bg1 })
hi('Cursor', { fg = c.bg0, bg = '#aeafad' })
hi('LineNr', { fg = c.comment })
hi('CursorLineNr', { fg = c.gray, bold = true })
hi('SignColumn', { bg = c.bg0 })
hi('FoldColumn', { fg = c.comment, bg = c.bg0 })
hi('Folded', { fg = c.gray, bg = c.bg1 })
hi('VertSplit', { fg = c.bg2 })
hi('WinSeparator', { fg = c.bg2 })
hi('Visual', { bg = c.bg3 })
hi('Search', { fg = c.fg, bg = '#515c6a' })
hi('IncSearch', { fg = c.bg0, bg = c.cyan })
hi('CurSearch', { fg = c.bg0, bg = c.cyan })
hi('MatchParen', { fg = c.magenta, bold = true })
hi('NonText', { fg = c.comment })
hi('Whitespace', { fg = c.bg2 })
hi('SpecialKey', { fg = c.comment })
hi('Directory', { fg = c.blue })
hi('Title', { fg = c.cyan, bold = true })
hi('Conceal', { fg = c.comment })
hi('EndOfBuffer', { fg = c.bg0 })
hi('QuickFixLine', { bg = c.bg3 })
hi('Winbar', { fg = c.fg_dim, bg = c.bg0 })
hi('WinbarNC', { fg = c.gray, bg = c.bg0 })

hi('StatusLine', { fg = c.fg, bg = c.statusbar })
hi('StatusLineNC', { fg = c.gray, bg = c.bg1 })
hi('TabLine', { fg = c.gray, bg = c.bg1 })
hi('TabLineSel', { fg = c.fg, bg = c.bg0 })
hi('TabLineFill', { bg = c.bg1 })

hi('Pmenu', { fg = c.fg, bg = c.bg2 })
hi('PmenuSel', { fg = c.fg, bg = c.bg3, bold = true })
hi('PmenuSbar', { bg = c.bg2 })
hi('PmenuThumb', { bg = c.comment })
hi('PmenuMatch', { fg = c.cyan, bold = true })
hi('PmenuMatchSel', { fg = c.cyan, bg = c.bg3, bold = true })
hi('WildMenu', { fg = c.bg0, bg = c.cyan })

hi('ErrorMsg', { fg = c.pink })
hi('WarningMsg', { fg = c.yellow })
hi('ModeMsg', { fg = c.fg, bold = true })
hi('MoreMsg', { fg = c.mint })
hi('Question', { fg = c.mint })

-- ── Syntax ──────────────────────────────────────────────────────────
hi('Comment', { fg = c.comment, italic = true })
hi('Constant', { fg = c.sand })
hi('String', { fg = c.sand })
hi('Character', { fg = c.sand })
hi('Number', { fg = c.sand })
hi('Boolean', { fg = c.blue })
hi('Float', { fg = c.sand })
hi('Identifier', { fg = c.mint })
hi('Function', { fg = c.cyan })
hi('Statement', { fg = c.blue })
hi('Conditional', { fg = c.blue })
hi('Repeat', { fg = c.blue })
hi('Label', { fg = c.blue })
hi('Operator', { fg = c.fg })
hi('Keyword', { fg = c.blue })
hi('Exception', { fg = c.blue })
hi('PreProc', { fg = c.blue })
hi('Include', { fg = c.blue })
hi('Define', { fg = c.blue })
hi('Macro', { fg = c.peri })
hi('Type', { fg = c.peri })
hi('StorageClass', { fg = c.blue })
hi('Structure', { fg = c.peri })
hi('Typedef', { fg = c.peri })
hi('Special', { fg = c.cyan })
hi('SpecialChar', { fg = c.magenta })
hi('Tag', { fg = c.blue })
hi('Delimiter', { fg = c.fg })
hi('SpecialComment', { fg = c.gray, italic = true })
hi('Underlined', { underline = true })
hi('Error', { fg = c.pink })
hi('Todo', { fg = c.bg0, bg = c.sand, bold = true })

-- ── Treesitter ──────────────────────────────────────────────────────
hi('@comment', { link = 'Comment' })
hi('@variable', { fg = c.mint })
hi('@variable.builtin', { fg = c.blue })
hi('@variable.parameter', { fg = c.mint })
hi('@variable.member', { fg = c.mint })
hi('@constant', { fg = c.sand })
hi('@constant.builtin', { fg = c.blue })
hi('@constant.macro', { fg = c.peri })
hi('@module', { fg = c.peri })
hi('@string', { fg = c.sand })
hi('@string.escape', { fg = c.magenta })
hi('@string.regexp', { fg = c.magenta })
hi('@string.special.url', { fg = c.cyan, underline = true })
hi('@character', { fg = c.sand })
hi('@number', { fg = c.sand })
hi('@boolean', { fg = c.blue })
hi('@function', { fg = c.cyan })
hi('@function.builtin', { fg = c.cyan })
hi('@function.call', { fg = c.cyan })
hi('@function.method', { fg = c.cyan })
hi('@function.method.call', { fg = c.cyan })
hi('@constructor', { fg = c.peri })
hi('@keyword', { fg = c.blue })
hi('@keyword.function', { fg = c.blue })
hi('@keyword.operator', { fg = c.blue })
hi('@keyword.return', { fg = c.blue })
hi('@keyword.conditional', { fg = c.blue })
hi('@keyword.repeat', { fg = c.blue })
hi('@keyword.import', { fg = c.blue })
hi('@keyword.exception', { fg = c.blue })
hi('@operator', { fg = c.fg })
hi('@punctuation.delimiter', { fg = c.fg })
hi('@punctuation.bracket', { fg = c.fg })
hi('@punctuation.special', { fg = c.magenta })
hi('@type', { fg = c.peri })
hi('@type.builtin', { fg = c.peri })
hi('@type.definition', { fg = c.peri })
hi('@attribute', { fg = c.mint })
hi('@property', { fg = c.mint })
hi('@label', { fg = c.blue })
hi('@tag', { fg = c.blue })
hi('@tag.builtin', { fg = c.blue })
hi('@tag.attribute', { fg = c.mint })
hi('@tag.delimiter', { fg = c.gray })
hi('@markup.heading', { fg = c.cyan, bold = true })
hi('@markup.link', { fg = c.blue, underline = true })
hi('@markup.link.url', { fg = c.cyan, underline = true })
hi('@markup.raw', { fg = c.sand })
hi('@markup.list', { fg = c.blue })
hi('@markup.strong', { bold = true })
hi('@markup.italic', { italic = true })
hi('@diff.plus', { fg = c.mint })
hi('@diff.minus', { fg = c.pink })

-- ── LSP & diagnostics ───────────────────────────────────────────────
hi('@lsp.type.class', { fg = c.peri })
hi('@lsp.type.decorator', { fg = c.cyan })
hi('@lsp.type.enum', { fg = c.peri })
hi('@lsp.type.interface', { fg = c.peri })
hi('@lsp.type.macro', { fg = c.peri })
hi('@lsp.type.namespace', { fg = c.peri })
hi('@lsp.type.parameter', { fg = c.mint })
hi('@lsp.type.property', { fg = c.mint })
hi('@lsp.type.struct', { fg = c.peri })
hi('@lsp.type.type', { fg = c.peri })
hi('@lsp.type.variable', { fg = c.mint })

hi('DiagnosticError', { fg = c.pink }) -- editorError.foreground
hi('DiagnosticWarn', { fg = c.yellow }) -- editorWarning.foreground
hi('DiagnosticInfo', { fg = c.blue }) -- editorInfo.foreground
hi('DiagnosticHint', { fg = c.cyan })
hi('DiagnosticOk', { fg = c.mint })
hi('DiagnosticUnderlineError', { sp = c.pink, undercurl = true })
hi('DiagnosticUnderlineWarn', { sp = c.yellow, undercurl = true })
hi('DiagnosticUnderlineInfo', { sp = c.blue, undercurl = true })
hi('DiagnosticUnderlineHint', { sp = c.cyan, undercurl = true })
hi('DiagnosticVirtualTextError', { fg = c.pink, bg = c.bg1 })
hi('DiagnosticVirtualTextWarn', { fg = c.yellow, bg = c.bg1 })
hi('DiagnosticVirtualTextInfo', { fg = c.blue, bg = c.bg1 })
hi('DiagnosticVirtualTextHint', { fg = c.cyan, bg = c.bg1 })

hi('LspReferenceText', { bg = '#004972' }) -- wordHighlightStrongBackground
hi('LspReferenceRead', { bg = '#004972' })
hi('LspReferenceWrite', { bg = '#004972' })
hi('LspInlayHint', { fg = c.comment, bg = c.bg1 })
hi('LspSignatureActiveParameter', { fg = c.cyan, bold = true })

-- ── Diff & git ──────────────────────────────────────────────────────
hi('DiffAdd', { bg = '#1d3b34' })
hi('DiffChange', { bg = c.bg1 })
hi('DiffDelete', { bg = '#3a1f28' })
hi('DiffText', { bg = c.bg3 })
hi('Added', { fg = c.mint }) -- gitDecoration.addedResourceForeground
hi('Changed', { fg = c.sand }) -- gitDecoration.modifiedResourceForeground
hi('Removed', { fg = c.pink }) -- gitDecoration.deletedResourceForeground
hi('GitSignsAdd', { fg = c.mint })
hi('GitSignsChange', { fg = c.sand })
hi('GitSignsDelete', { fg = c.pink })

-- ── Plugins in this config ──────────────────────────────────────────
hi('TelescopeNormal', { fg = c.fg, bg = c.bg1 })
hi('TelescopeBorder', { fg = c.bg2, bg = c.bg1 })
hi('TelescopeTitle', { fg = c.fg, bg = c.statusbar, bold = true })
hi('TelescopeSelection', { bg = c.bg3, bold = true })
hi('TelescopeMatching', { fg = c.cyan, bold = true })
hi('TelescopePromptPrefix', { fg = c.magenta })

hi('NeoTreeNormal', { fg = c.fg_dim, bg = c.bg1 })
hi('NeoTreeNormalNC', { fg = c.fg_dim, bg = c.bg1 })
hi('NeoTreeDirectoryName', { fg = c.blue })
hi('NeoTreeDirectoryIcon', { fg = c.blue })
hi('NeoTreeRootName', { fg = c.cyan, bold = true })
hi('NeoTreeGitModified', { fg = c.sand })
hi('NeoTreeGitAdded', { fg = c.mint })
hi('NeoTreeGitDeleted', { fg = c.pink })
hi('NeoTreeGitIgnored', { fg = c.gray })
hi('NeoTreeIndentMarker', { fg = c.bg2 })

hi('BlinkCmpMenu', { fg = c.fg, bg = c.bg2 })
hi('BlinkCmpMenuBorder', { fg = c.cyan, bg = c.bg2 })
hi('BlinkCmpMenuSelection', { bg = c.bg3, bold = true })
hi('BlinkCmpLabelMatch', { fg = c.cyan, bold = true })
hi('BlinkCmpKind', { fg = c.peri })
hi('BlinkCmpDoc', { fg = c.fg, bg = c.bg2 })
hi('BlinkCmpDocBorder', { fg = c.cyan, bg = c.bg2 })

hi('WhichKey', { fg = c.magenta })
hi('WhichKeyGroup', { fg = c.blue })
hi('WhichKeyDesc', { fg = c.fg })
hi('WhichKeySeparator', { fg = c.comment })
hi('WhichKeyFloat', { bg = c.bg2 })

hi('FidgetTask', { fg = c.gray })
hi('FidgetTitle', { fg = c.cyan })

hi('DapBreakpoint', { fg = c.pink })
hi('DapStopped', { fg = c.sand })
hi('NeotestPassed', { fg = c.mint })
hi('NeotestFailed', { fg = c.pink })
hi('NeotestRunning', { fg = c.sand })
hi('NeotestSkipped', { fg = c.gray })

-- ── Terminal ────────────────────────────────────────────────────────
-- Verbatim from the source theme's terminal.ansi* keys.
vim.g.terminal_color_0 = '#17191e'
vim.g.terminal_color_1 = '#dc3657'
vim.g.terminal_color_2 = '#23d18b'
vim.g.terminal_color_3 = '#ffc368'
vim.g.terminal_color_4 = '#2b7eca'
vim.g.terminal_color_5 = '#ad5dca'
vim.g.terminal_color_6 = '#24c0cf'
vim.g.terminal_color_7 = '#eef0f9'
vim.g.terminal_color_8 = '#545864'
vim.g.terminal_color_9 = '#f4587e'
vim.g.terminal_color_10 = '#4bf3c8'
vim.g.terminal_color_11 = '#ffd493'
vim.g.terminal_color_12 = '#54b9ff'
vim.g.terminal_color_13 = '#cc75f4'
vim.g.terminal_color_14 = '#00daef'
vim.g.terminal_color_15 = '#fafafa'
