-- highlight helper adapted from hrsh7th
local highlight = {}

highlight.keys = {
  "fg",
  "bg",
  "bold",
  "italic",
  "reverse",
  "standout",
  "underline",
  "undercurl",
  "strikethrough",
}

highlight.override = function(group, settings)
  for _, key in ipairs(highlight.keys) do
    if not settings[key] then
      local v = vim.fn.synIDattr(vim.fn.hlID(group), key)
      if key == "fg" or key == "bg" then
        local n = tonumber(v, 10)
        v = type(n) == "number" and n or v
      else
        v = v == 1
      end
      settings[key] = v == "" and "NONE" or v
    end
  end
  vim.api.nvim_set_hl(0, group, settings)
end

local dracula_customization = vim.api.nvim_create_augroup("Dracula Customization", {})

vim.api.nvim_create_autocmd("Colorscheme", {
  group = dracula_customization,
  pattern = "dracula",
  callback = function()
    highlight.override("DraculaWinSeparator", { bg = "None" })
  end,
  desc = "Override default style of WinSeparator.",
})

vim.api.nvim_create_autocmd("user", {
  group = dracula_customization,
  pattern = "CmpReady",
  command = "runtime after/plugin/dracula.vim",
  desc = "Re-source Dracula theme when nvim-cmp is loaded.",
})

vim.cmd [[colorscheme dracula]]
