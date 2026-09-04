-- ============================================================
-- RUST
-- rust-analyzer, debugging, tests, and Cargo.toml tooling
-- ============================================================
--
-- rustaceanvim owns rust-analyzer itself, via `vim.g.rustaceanvim` rather than
-- `vim.lsp.config`. Do NOT also add `rust_analyzer` to the `servers` table in
-- init.lua: two clients would attach to every buffer and you'd get every
-- diagnostic and completion twice.

local function gh(repo) return 'https://github.com/' .. repo end

-- ── LSP ─────────────────────────────────────────────────────────────
vim.pack.add { { src = gh 'mrcjkb/rustaceanvim', version = vim.version.range '9.*' } }

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      local map = function(keys, cmd, desc)
        vim.keymap.set('n', keys, function() vim.cmd.RustLsp(cmd) end, { buffer = bufnr, desc = 'Rust: ' .. desc })
      end

      -- Plain `K` is hover; this variant stacks actions onto the same popup
      -- (jump to docs.rs, view the desugared type). Press K twice to reach them.
      map('K', { 'hover', 'actions' }, 'Hover actions')

      map('<leader>ra', 'codeAction', 'Code [A]ction')
      map('<leader>rr', 'runnables', '[R]unnables')
      map('<leader>rd', 'debuggables', '[D]ebuggables')
      map('<leader>rt', 'testables', '[T]estables')
      map('<leader>re', 'expandMacro', '[E]xpand macro')
      map('<leader>rc', 'openCargo', 'Open [C]argo.toml')
      map('<leader>rp', 'parentModule', '[P]arent module')
      map('<leader>rD', 'openDocs', 'Open [D]ocs.rs')

      -- Not a RustLsp subcommand: rust-analyzer has no organize-imports, so
      -- this walks the diagnostics itself. See lua/custom/rust-import-all.lua.
      vim.keymap.set('n', '<leader>ri', require('custom.rust-import-all').import_all_missing, { buffer = bufnr, desc = 'Rust: [I]mport all missing' })
    end,

    default_settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          buildScripts = { enable = true },
        },

        -- clippy instead of plain `cargo check` on save: same wall-clock cost,
        -- because it reuses the check artifacts, but far more useful lints.
        checkOnSave = true,
        check = { command = 'clippy', extraArgs = { '--no-deps' } },

        -- Off by default and worth having: without it, any crate using derive
        -- macros (serde, thiserror, clap) looks like a sea of red.
        procMacro = { enable = true },

        inlayHints = {
          parameterHints = { enable = true },
          typeHints = { enable = true },
          closureReturnTypeHints = { enable = 'with_block' },
          -- Noisy in idiomatic code, where `ref`/`mut` are usually obvious.
          bindingModeHints = { enable = false },
        },
      },
    },
  },
}

-- ── Tests ───────────────────────────────────────────────────────────
-- neotest drives rustaceanvim's own adapter, so test discovery goes through
-- rust-analyzer's runnables. That means no cargo-nextest to install, and
-- `<leader>Td` debugs a single test through the same codelldb setup.
vim.pack.add {
  gh 'nvim-neotest/neotest',
  gh 'nvim-neotest/nvim-nio',
  gh 'antoinemadec/FixCursorHold.nvim',
}

require('neotest').setup {
  adapters = { require 'rustaceanvim.neotest' },
}

local neotest = require 'neotest'
local tmap = function(keys, func, desc) vim.keymap.set('n', keys, func, { desc = desc }) end

-- <leader>t is already the [T]oggle group, so tests live under <leader>T.
tmap('<leader>Tt', function() neotest.run.run() end, '[T]est nearest')
tmap('<leader>Tf', function() neotest.run.run(vim.fn.expand '%') end, '[T]est [F]ile')
tmap('<leader>Tl', function() neotest.run.run_last() end, '[T]est [L]ast')
tmap('<leader>Td', function() neotest.run.run { strategy = 'dap' } end, '[T]est [D]ebug nearest')
tmap('<leader>Ts', function() neotest.summary.toggle() end, '[T]est [S]ummary')
tmap('<leader>To', function() neotest.output.open { enter = true } end, '[T]est [O]utput')
tmap('<leader>TO', function() neotest.output_panel.toggle() end, '[T]est [O]utput panel')

-- ── Cargo.toml ──────────────────────────────────────────────────────
-- Version completion, "latest is x.y.z" virtual text, and upgrade code actions.
-- `lsp.enabled` runs it as a real language server, so blink.cmp picks up its
-- completions through the existing `lsp` source — no extra wiring needed.
vim.pack.add { { src = gh 'saecki/crates.nvim', version = vim.version.range '0.7.*' } }

require('crates').setup {
  completion = { crates = { enabled = true } },
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
}
