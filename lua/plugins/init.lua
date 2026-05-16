return {
  -- Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file tree", silent = true },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",       desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",        desc = "Live grep" },
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",  desc = "Definitions" },
      { "gr",         "<cmd>Telescope lsp_references<cr>",   desc = "References" },
      { "gi",         "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    },
    config = function()
      require("telescope").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "typescript", "javascript", "rust", "json", "markdown" },
        highlight = { enable = true }
      }
    end
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          theme = "catppuccin",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            "encoding",
            "filetype",
          },
        },
      }
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      background = { light = "latte", dark = "mocha" },
      blur = {
        enabled = true,
        timeout = 100,
      },
      integrations = {
        treesitter = true,
        lualine = true,
        mason = true,
        telescope = true,
        nvimtree = true,
        which_key = true,
        bufferline = true,
        gitsigns = true,
        mini = { enabled = true },
      },
      transparent_background = true,
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "ts_ls", "lua_ls" },
        automatic_enable = { exclude = { "stylua" } },
      }
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
      vim.lsp.enable({ "ts_ls", "lua_ls" })
    end
  }

}
