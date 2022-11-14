local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

function on_attach() 
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer=0})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer=0})
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer=0})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer=0})
  vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer=0})
  vim.keymap.set("n", "dl", "<cmd>Telescope diagnostics<CR>", { buffer=0})
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
end

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      }
    }
  }
}

lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

