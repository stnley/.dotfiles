local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace = vim.env.XDG_CACHE_HOME .. "/jdtls/" .. project_name

local config = {
  cmd = {
    -- changing command because package from AUR includes its own launch
    -- script for jdtls which conflicts with the args here
    "jdtls",

    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-data",
    jdtls_workspace,
  },
  settings = {
    java = {},
  },

  init_options = {
    bundles = {},
  },
}

require("jdtls").start_or_attach(config)
