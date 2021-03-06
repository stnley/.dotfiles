return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    use { "dracula/vim", as = "dracula" }

    --    use { "chriskempson/base16-vim" }

    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require "stnley.plugins.treesitter"
      end,
      run = ":TSUpdate",
    }

    use {
      "neovim/nvim-lspconfig",
      config = function()
        require "stnley.plugins.lsp"
      end,
    }

    use { "mfussenegger/nvim-jdtls", ft = "java" }

    use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "kyazdani42/nvim-web-devicons", opt = true },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      config = function()
        require "stnley.plugins.telescope"
      end,
    }

    use {
      "hrsh7th/nvim-cmp",
      transitive_opt = true,
      opt = true,
      requires = {
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip" },
      },
      event = "InsertEnter",
      config = function()
        require "stnley.plugins.cmp"
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end,
      cmd = "Trouble",
    }

    --  use {
    --    "akinsho/toggleterm.nvim",
    --    config = function()
    --      require "stnley.config.toggleterm"
    --    end,
    --    -- cmd = "ToggleTerm",
    --    event = "BufRead",
    --  }

    use {
      "tpope/vim-fugitive",
      cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    }

    use { "tpope/vim-commentary" }

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {}
      end,
      module = "zen-mode",
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitsigns").setup {}
      end,
      event = "BufRead",
    }

    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup {
          options = { theme = "dracula", globalstatus = true },
        }
      end,
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup {}
        vim.cmd [[ColorizerAttachToBuffer]]
      end,
      event = "BufRead",
    }

    use {
      "nvim-lua/plenary.nvim",
      module = "plenary",
      module_pattern = "plenary.*",
    }

    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
    }

    use {
      "L3MON4D3/LuaSnip",
      module = "luasnip",
    }
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
