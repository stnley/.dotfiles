-- vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
--   if err ~= nil or result == nil then
--     return
--   end
--   if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--     local view = vim.fn.winsaveview()
--     vim.lsp.util.apply_text_edits(result, bufnr)
--     vim.fn.winrestview(view)
--   end
-- end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
  })(...)
  pcall(vim.diagnostic.set_loclist, { open = false })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.floating_window_border_dark,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = vim.g.floating_window_border_dark,
})
