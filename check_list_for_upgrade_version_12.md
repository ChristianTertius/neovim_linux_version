# Neovim v0.10 → v0.12 Upgrade Checklist

> Based on config analysis at `/home/budi/.config/nvim`
> Current version: `NVIM v0.10.2`

---

## 🔴 MUST FIX — Akan error jika tidak diperbaiki

### 1. `vim.loop` → `vim.uv`
- **File:** `lua/budi/lazy.lua:3`
- **Change:**
  ```diff
  - if not vim.loop.fs_stat(lazypath) then
  + if not vim.uv.fs_stat(lazypath) then
  ```
- **Reason:** `vim.loop` fully removed in 0.12.

---

### 2. nvim-treesitter — config perlu refactor total
- **File:** `lua/budi/plugins/treesitter.lua`
- **Changes:**
  - `require("nvim-treesitter.configs")` module **tidak ada lagi** di 0.12
  - Highlighting sudah **built-in dan aktif by default**
  - `incremental_selection` module dihapus dari nvim-treesitter
  - `nvim-ts-autotag` mungkin belum support versi baru nvim-treesitter
- **What to do:**
  - Hapus blok `treesitter.setup({...})`
  - Ganti dengan `nvim-treesitter` versi baru (main branch yg di-refactor) atau gunakan built-in TS
  - Untuk install parser, gunakan `:TSInstall <lang>` langsung
  - Incremental selection: ganti ke fitur core 0.12 (`v_an`/`v_in`/`v_]n`/`v_[n`)

---

### 3. Diagnostic sign icons tidak bisa pakai `vim.fn.sign_define`
- **File:** `lua/budi/plugins/lsp/lspconfig.lua:98-100`
- **Change:**
  ```diff
  - local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  - for type, icon in pairs(signs) do
  -   local hl = "DiagnosticSign" .. type
  -   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  - end
  + vim.diagnostic.config({
  +   signs = {
  +     text = {
  +       [vim.diagnostic.severity.ERROR] = " ",
  +       [vim.diagnostic.severity.WARN] = " ",
  +       [vim.diagnostic.severity.HINT] = "󰠠 ",
  +       [vim.diagnostic.severity.INFO] = " ",
  +     },
  +   },
  + })
  ```
- **Reason:** `vim.fn.sign_define` untuk diagnostic signs sudah tidak works di 0.12 (deprecated sejak 0.10).

---

### 4. `:LspRestart` command dihapus
- **File:** `lua/budi/plugins/lsp/lspconfig.lua` (keymap `<leader>rs`)
- **Change:**
  ```diff
  - keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
  + keymap.set("n", "<leader>rs", ":lsp restart<CR>", opts)
  ```
- **Reason:** `:LspRestart`, `:LspStart`, `:LspStop`, `:LspInfo` dihapus di 0.12. Ganti dengan `:lsp <subcommand>` atau `:checkhealth vim.lsp`.

---

## 🟡 RECOMMENDED — Deprecated, masih jalan tapi sebaiknya migrasi

### 5. `vim.diagnostic.goto_prev` / `goto_next` → `vim.diagnostic.jump()`
- **File:** `lua/budi/plugins/lsp/lspconfig.lua`
- **Change:**
  ```diff
  - keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  - keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  + keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
  + keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
  ```
- **Note:** `]d`/`[d` juga sudah built-in default keymap di 0.12, bisa dihapus saja.

---

### 6. `vim.lsp.get_active_clients()` → `vim.lsp.get_clients()`
- **File:** `lua/budi/plugins/lualine.lua`
- **Change:**
  ```diff
  - local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  + local clients = vim.lsp.get_clients({ bufnr = 0 })
  ```
- **Reason:** `get_active_clients` deprecated sejak 0.10.

---

### 7. LSP keymaps built-in — redundant
- **File:** `lua/budi/plugins/lsp/lspconfig.lua`
- Di 0.12, keymap berikut sudah **default built-in**:
  - `K` → hover
  - `grn` → rename
  - `gra` → code action
  - `grr` → references
  - `gri` → implementations
  - `grt` → type definition
  - `]d`/`[d` → diagnostic jump
- **What to do:** Tidak wajib dihapus, cuma redundant. Tapi jika mau rapi, bisa di-comment atau dihapus.

---

### 8. `neodev.nvim` kemungkinan tidak diperlukan
- **File:** `lua/budi/plugins/lsp/lspconfig.lua:6`
- **Reason:** Di 0.12, `lazydev.nvim` (yang sudah kamu pakai di nvim-cmp) sudah menangani setup Lua LSP. `neodev.nvim` bisa di-drop.
- **Action:** Bisa dihapus dari dependencies lspconfig dan plugin list.

---

## 🟢 OPTIONAL / NICE TO HAVE

### 9. Migrasi dari nvim-lspconfig ke native `vim.lsp.config()`
- **File:** `lua/budi/plugins/lsp/lspconfig.lua`
- 0.12 mendukung native LSP config tanpa plugin:
  ```lua
  vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        completion = { callSnippet = "Replace" },
      },
    },
  }
  vim.lsp.enable("lua_ls")
  ```
- `nvim-lspconfig` masih bisa dipakai tapi **explicitly deprecated**. Migrasi opsional.
- `mason-lspconfig` v2 juga sudah support `vim.lsp.config` API.

---

### 10. Telescope branch
- **File:** `lua/budi/plugins/telescope.lua:2`
- **Change:**
  ```diff
  - branch = "0.1.x",
  + -- Hapus atau biarkan, 0.1.x masih works
  ```
- Pastikan telescope dan fzf-native di-versi terbaru.

---

### 11. `vim.diff` → `vim.text.diff`
- Jika ada kode yang pakai `vim.diff()`, ganti ke `vim.text.diff()`.
- Tidak ditemukan di config kamu, tapi perlu diingat.

---

### 12. `vim.lsp.semantic_tokens.start/stop` → `.enable()`
- Tidak ditemukan di config kamu, tapi jika pakai semantic tokens di masa depan, gunakan `vim.lsp.semantic_tokens.enable(true/false)`.

---

### 13. `'shelltemp'` default ke `false`
- Jika ada plugin atau custom command yang bergantung pada `'shelltemp'`, perlu di-check.

---

## ✅ Plugin Compatibility Check

| Plugin | Status | Notes |
|--------|--------|-------|
| lazy.nvim | ✅ OK | |
| nvim-treesitter | ❌ **Archived/Refactored** | Perlu refactor config |
| nvim-treesitter-textobjects | ⚠️ | Cek kompatibilitas |
| nvim-ts-autotag | ⚠️ | Cek update terbaru |
| nvim-lspconfig | ⚠️ Deprecated | Masih works, tapi deprecated |
| mason.nvim | ✅ OK | |
| mason-lspconfig | ⚠️ v2 changes | Update ke v2 |
| mason-tool-installer | ✅ OK | |
| nvim-cmp | ✅ OK | |
| telescope.nvim | ✅ OK | |
| which-key.nvim | ✅ OK | |
| lualine.nvim | ✅ OK | |
| gitsigns.nvim | ✅ OK | |
| tokyonight.nvim | ✅ OK | |
| kanagawa.nvim | ✅ OK | |
| trouble.nvim | ✅ OK | |
| toggleterm.nvim | ✅ OK | |
| nvim-tree.lua | ✅ OK | |
| Comment.nvim | ✅ OK | |
| nvim-surround | ✅ OK | |
| nvim-autopairs | ✅ OK | |
| harpoon | ⚠️ Not actively maintained | Cek ThePrimeagen/harpoon update |
| conform.nvim | ✅ OK | |
| leap.nvim | ✅ OK | |

---

## 📋 Quick Action Summary

```
lazy.lua           → vim.loop → vim.uv
treesitter.lua     → Refactor total (plugin archived)
lspconfig.lua      → sign_define → diagnostic.config
lspconfig.lua      → :LspRestart → :lsp restart
lspconfig.lua      → goto_prev/next → jump() [recommended]
lualine.lua        → get_active_clients → get_clients [recommended]
lspconfig.lua      → neodev.nvim bisa di-drop [optional]
lspconfig.lua      → Migrasi ke vim.lsp.config() [optional]
telescope.lua      → Branch check [optional]
```
