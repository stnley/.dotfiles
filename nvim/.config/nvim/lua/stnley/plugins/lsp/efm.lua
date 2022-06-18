-- local black = require "stnley.lsp.efm.black"
-- local flake8 = require "stnley.lsp.efm.flake8"
-- local isort = require "stnley.lsp.efm.isort"
-- local mypy = require "stnley.lsp.efm.mypy"
-- local prettier = require "stnley.lsp.efm.prettier"
-- local shellcheck = require "stnley.lsp.efm.shellcheck"
-- local shfmt = require "stnley.lsp.efm.shfmt"
-- local stylua = require "stnley.lsp.efm.stylua"
-- local terraform = require "stnley.lsp.efm.terraform"

-- return {
--   lua = { stylua },
--   json = { prettier },
--   python = { black, isort, flake8, mypy },
--   sh = { shellcheck, shfmt },
--   terraform = { terraform },
--   yaml = { prettier },
-- }
--
--
local M = {}

local stylua = {
  formatCommand = "stylua -",
  formatStdin = true,
}

M.lua = { stylua }

local black = {
  formatCommand = "black --target-version py310 -",
  formatStdin = true,
}

local isort = {
  formatCommand = "isort --stdout --profile black -",
  formatStdin = true,
}

local flake8 = {
  lintCommand = "flake8 --max-line-length 88 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
  lintSource = "flake8",
}

local mypy = {
  lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
  lintSource = "mypy",
}

M.python = { black, isort, flake8, mypy }

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  lintSource = "shellcheck",
}

local shfmt = {
  formatCommand = "shfmt ${-i:tabWidth}",
}

M.sh = { shellcheck, shfmt }

local terraform = {
  formatCommand = "terraform fmt -",
  formatStdin = true,
}

M.terraform = { terraform }

local prettier = {
  formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    ${--config-precedence:configPrecedence}
    ${--tab-width:tabWidth}
    ${--trailing-comma:trailingComma}
  ]]):gsub("\n", ""),
}

M.json = { prettier }

M.yaml = { prettier }

return M
