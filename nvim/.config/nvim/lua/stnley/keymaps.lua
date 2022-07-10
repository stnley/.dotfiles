local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

-- greatest remap ever
keymap("v", "<leader>p", '"_dP', opts)

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)

keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)

-- move lines
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)

keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)

keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

--
-- plugin specific
--

-- lsp client
keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "<leader>gi", " <cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>gsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "<leader>sd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- gitsigns
keymap("n", "<leader>hp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", opts)
keymap("n", "<leader>hs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", opts)
keymap("n", "<leader>hr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", opts)
keymap("n", "<leader>hd", "<cmd>lua require('gitsigns').diffthis()<CR>", opts)
keymap("n", "<leader>td", "<cmd>lua require('gitsigns').toggle_deleted()<CR>", opts)

-- zen-mode
keymap("n", "<leader>z", "<cmd>lua require('zen-mode').toggle()<CR>", opts)

-- telescope
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').find_files({ hidden=true })<CR>", opts)
keymap("n", "<leader>ht", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)

-- trouble
keymap("n", "<leader>xx", "<cmd>Trouble<CR>", opts)
keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", opts)
keymap("n", "<leader>xl", "<cmd>Trouble loclist<CR>", opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<CR>", opts)
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", opts)

-- hop
keymap("", "<C-f>", "<cmd>lua require'hop'.hint_words()<cr>", opts)
keymap("", "t", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
keymap("", "T", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
