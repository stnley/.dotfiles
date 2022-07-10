require "stnley.plugins.lsp.diagnostics"
require "stnley.plugins.lsp.handlers"

local lspconfig = require "lspconfig"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, _)
  local group = vim.api.nvim_create_augroup("LSP Commands", {})
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      desc = "Highlight references to symbol under cursor when held in place.",
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      desc = "Clear highlight highlights of symbol under cursor.",
    })
  end

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      once = true,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "Refresh codelens when entering buffer.",
    })

    vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
      group = group,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      desc = "Refresh codelens when saving buffer or holding cursor.",
    })
  end
end

local format_on_save = function(client, bufnr)
  local group = vim.api.nvim_create_augroup("LSP Formatting", {})
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { "<buffer>" },
    callback = function()
      local params = vim.lsp.util.make_formatting_params {}
      client.request("textDocument/formatting", params, nil, bufnr)
    end,
    desc = "Format text with LSP server when saving buffer.",
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.bashls.setup {
  on_init = custom_init,
  on_attach = function(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.dockerls.setup {
  on_init = custom_init,
  on_attach = function(client, bufnr)
    format_on_save(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
}

local formatters = require "stnley.plugins.lsp.efm"
lspconfig.efm.setup {
  on_attach = function(client, bufnr)
    format_on_save(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
  init_options = { documentFormatting = true },
  root_dir = vim.loop.cwd,
  filetypes = vim.tbl_keys(formatters),
  settings = {
    rootMarkers = { ".git/", "stylua.toml" },
    languages = formatters,
  },
}

lspconfig.emmet_ls.setup {
  on_init = custom_init,
  on_attach = function(client, bufnr)
    -- TODO (stnley): figure out if this server supports formatting?
    format_on_save(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.eslint.setup {
  on_init = custom_init,
  on_attach = function(client)
    local group = vim.api.nvim_create_augroup("Eslint", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "<buffer>",
      command = "EslintFixAll",
      desc = "Run eslint when saving buffer.",
    })
    custom_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.html.setup {
  on_init = custom_init,
  on_attach = function(client, bufnr)
    -- TODO (stnley): figure out if this server supports formatting?
    format_on_save(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = capabilities,
}

local user = vim.fn.expand "$USER"
local sumneko_root_path = "/home/" .. user .. "/apps/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
lspconfig.sumneko_lua.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = capabilities,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.terraformls.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  on_init = custom_init,
  on_attach = function(client, bufnr)
    -- TODO (stnley): do we want this to format or something else?
    format_on_save(client, bufnr)
    custom_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = capabilities,
}
