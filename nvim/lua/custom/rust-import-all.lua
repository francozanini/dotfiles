-- Add every missing `use` in the buffer at once.
--
-- rust-analyzer has no "organize imports" command: auto-import is an assist
-- offered one unresolved name at a time, so this walks the diagnostics and
-- takes the `Import …` action at each of them.

local M = {}

local IMPORTABLE = {
  E0405 = true,
  E0412 = true,
  E0422 = true,
  E0425 = true,
  E0433 = true,
  E0531 = true,
  E0599 = true, -- a method that exists but whose trait isn't in scope
  ['unresolved-ident'] = true,
  ['unresolved-import'] = true,
  ['unresolved-macro-call'] = true,
}

local function is_importable(diagnostic)
  if IMPORTABLE[tostring(diagnostic.code)] then return true end
  local message = diagnostic.message or ''
  return message:find 'cannot find' ~= nil
    or message:find 'failed to resolve' ~= nil
    or message:find 'unresolved' ~= nil
    or message:find 'no method named' ~= nil
end

-- rustc names the trait or type it means: "perhaps you want to import it:
-- `use ratatui::prelude::Stylize;`". rust-analyzer's own ranking does not —
-- for a `.bg()` call it offers owo_colors' OwoColorize ahead of ratatui's
-- Stylize, and picking that compiles into a different method entirely.
local function rustc_suggestions(bufnr)
  local suggested = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    for path in (diagnostic.message or ''):gmatch 'use ([%w_:]+);' do
      suggested[M.fingerprint(path)] = true
    end
  end
  return suggested
end

-- Crate plus final segment, so rustc's `ratatui::prelude::Stylize` still
-- matches rust-analyzer's `ratatui::style::Stylize` — same trait, two re-exports.
function M.fingerprint(path)
  local segments = vim.split(path, '::')
  return segments[1] .. '::' .. segments[#segments]
end

local function import_candidates(result)
  local candidates, seen = {}, {}
  for _, action in ipairs(result or {}) do
    local path = action.title and action.title:match '^Import `([^`]+)`$'
    -- `Import X as _` brings in the same path, just anonymously.
    if path and not path:find ' as ' and not seen[path] then
      seen[path] = true
      candidates[#candidates + 1] = { action = action, path = path }
    end
  end
  return candidates
end

function M.import_all_missing()
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'rust-analyzer' })[1]
  if not client then return vim.notify('rust-analyzer is not attached here', vim.log.levels.WARN) end

  -- Anchor the positions with extmarks: every import we apply inserts a `use`
  -- line near the top and shifts everything below it, so the diagnostics' own
  -- line numbers are stale the moment the first one lands.
  local ns = vim.api.nvim_create_namespace 'rust-import-all'
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local marks, seen = {}, {}
  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    local key = diagnostic.lnum .. ':' .. diagnostic.col
    -- rustc repeats itself: one diagnostic per use site, plus a "consider
    -- importing" note pinned to line 0. One request per spot is enough.
    if is_importable(diagnostic) and not seen[key] then
      seen[key] = true
      marks[#marks + 1] = vim.api.nvim_buf_set_extmark(bufnr, ns, diagnostic.lnum, diagnostic.col, {})
    end
  end
  if #marks == 0 then return vim.notify 'No unresolved names to import' end

  local suggested = rustc_suggestions(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local applied, ambiguous, index = 0, 0, 0

  local function apply(action)
    if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding) end
    if action.command then client:exec_cmd(type(action.command) == 'table' and action.command or action, { bufnr = bufnr }) end
    applied = applied + 1
  end

  -- One at a time, not batched: each action is computed against the current
  -- buffer, which is what lets rust-analyzer fold them into one `use` tree
  -- instead of stacking a separate line per import.
  local step
  step = function()
    index = index + 1
    if index > #marks then
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      pcall(vim.api.nvim_win_set_cursor, 0, cursor)
      local message = ('Added %d import%s'):format(applied, applied == 1 and '' or 's')
      if ambiguous > 0 then message = message .. (', %d left ambiguous'):format(ambiguous) end
      return vim.notify(message)
    end

    local position = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns, marks[index], {})
    vim.api.nvim_win_set_cursor(0, { position[1] + 1, position[2] })
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { diagnostics = {}, triggerKind = 1 }

    client:request('textDocument/codeAction', params, function(_, result)
      local candidates = import_candidates(result)
      local action
      for _, candidate in ipairs(candidates) do
        if suggested[M.fingerprint(candidate.path)] then
          action = candidate.action
          break
        end
      end
      -- Only one place it could come from, so rustc's silence doesn't matter.
      if not action and #candidates == 1 then action = candidates[1].action end
      if not action then
        if #candidates > 1 then ambiguous = ambiguous + 1 end
        return step()
      end
      if action.edit or action.command then
        apply(action)
        return step()
      end
      client:request('codeAction/resolve', action, function(_, resolved)
        if resolved then apply(resolved) end
        step()
      end, bufnr)
    end, bufnr)
  end

  step()
end

return M
