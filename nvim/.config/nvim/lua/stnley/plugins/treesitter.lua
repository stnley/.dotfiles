local has_treesitter = pcall(require, "nvim-treesitter")

if not has_treesitter then
  return
end

-- if local_treesitter then
require("nvim-treesitter.configs").setup {
  ensure_installed = {

    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "go",
    "hcl",
    "help",
    "java",
    "javascript",
    "jsdoc",
    "kotlin",
    "lua",
    "make",
    "perl",
    "php",
    "phpdoc",
    "python",
    "rst",
    "ruby",
    "rust",
    "scala",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "yang",
  },
  highlight = {
    enable = true,
    use_languagetree = false,
    disable = { "json" },
  },
}
-- end
