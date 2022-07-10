local M = {}

local stylua = {
  formatCommand = "stylua -",
  formatStdin = true,
}

local black = {
  formatCommand = "black -",
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

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  lintSource = "shellcheck",
}

local shfmt = {
  formatCommand = "shfmt ${-i:tabWidth}",
}

local terraform = {
  formatCommand = "terraform fmt -",
  formatStdin = true,
}

local prettier = {
  formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    ${--config-precedence:configPrecedence}
    ${--tab-width:tabWidth}
    ${--trailing-comma:trailingComma}
  ]]):gsub("\n", ""),
}

M.json = { prettier }
M.lua = { stylua }
M.python = { black, isort, flake8, mypy }
M.sh = { shellcheck, shfmt }
M.terraform = { terraform }
M.yaml = { prettier }

return M
