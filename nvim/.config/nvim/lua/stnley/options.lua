local opt = vim.opt

opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + {
  "*.pyc",
  "*pycache*",
  "**/coverage/*",
  "**/node_modules/*",
  "**/.git/*",
}

opt.guicursor = ""
opt.cursorline = true
opt.hidden = true
opt.hlsearch = false
opt.incsearch = true
opt.number = true -- show actual number of current line
opt.relativenumber = true -- show line numbers
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.splitright = true -- prefer windows split to right
opt.splitbelow = true -- prefer windows split to bottom

opt.colorcolumn = "80"
opt.termguicolors = true
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1

opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4
opt.wrap = false
opt.clipboard = "unnamedplus"
opt.belloff = "all"

opt.backup = false
opt.undodir = os.getenv "XDG_CACHE_HOME" .. "/.nvim/undodir"
opt.undofile = true
opt.swapfile = false

opt.mouse = "n"

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

local highlight_yank = vim.api.nvim_create_augroup("Highlight Yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { timeout = 75 }
  end,
  desc = "Highlight yanked text.",
})

local remove_whitespace = vim.api.nvim_create_augroup("Remove Whitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = remove_whitespace,
  pattern = "*",
  command = [[ %s/\s\+$//e ]],
  desc = "Remove trailing whitespace from each line when saving buffer.",
})
