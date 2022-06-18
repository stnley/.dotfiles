local has_cmp, local_cmp = pcall(require, "cmp")
if not has_cmp then
  return
end

local mapping = require "cmp.config.mapping"
local types = require "cmp.types"
local luasnip = require "luasnip"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local cmp_kinds = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = "  ",
}

local_cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = local_cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = local_cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = local_cmp.mapping.complete(),
    ["<C-e>"] = local_cmp.mapping.abort(),
    ["<CR>"] = local_cmp.mapping.confirm { select = true },
    ["<Tab>"] = local_cmp.mapping(function(fallback)
      if local_cmp.visible() then
        local_cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        local_cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = mapping(mapping.select_next_item { behavior = types.cmp.SelectBehavior.Insert }, { "i", "c" }),
    ["<S-Tab>"] = local_cmp.mapping(function(fallback)
      if local_cmp.visible() then
        local_cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = mapping(mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }, { "i", "c" }),
    ["<C-y>"] = local_cmp.mapping.confirm { select = false },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
      })[entry.source.name]
      return vim_item
    end,
  },
  enabled = function()
    -- disable completion in comments
    local context = require "cmp.config.context"
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
    end
  end,
}

local_cmp.setup.cmdline("/", {
  mapping = local_cmp.mapping.preset.cmdline(),
  sources = local_cmp.config.sources {
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  },
})

local_cmp.setup.cmdline(":", {
  mapping = local_cmp.mapping.preset.cmdline(),
  sources = local_cmp.config.sources {
    { name = "path" },
    { name = "cmdline" },
  },
})
