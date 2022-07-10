if require "stnley.first_load"() then
  return
end

vim.g.mapleader = [[ ]]

require "stnley.disable_builtins"
require "stnley.options"
require "stnley.keymaps"
require "stnley.plugins"
require "stnley.colorscheme"

-- vim.cmd [[
--     augroup ReplaceNetrw
--         autocmd!
--         autocmd VimEnter * silent!
--         autocmd StdinReadPre * let s:std_in=1
--         autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call luaeval("require('telescope').extensions.file_browser.file_browser({cwd = _A})", argv()[0]) | endif
--     augroup END
-- ]]
