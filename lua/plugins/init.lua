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
    branch = "master",
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
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = { ["<esc>"] = actions.close },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = { "lua", "typescript", "javascript", "tsx", "rust", "json", "markdown", "vim", "vimdoc", "query" }
      require("nvim-treesitter").install(langs)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          theme = "tokyonight",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "filename",
              path = 1,
              color = { fg = "#cdd6f4", bg = "#313244", gui = "bold" },
            },
          },
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
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",          -- night | storm | day | moon
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end,
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
        ensure_installed = { "ts_ls", "lua_ls", "jsonls" },
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
      vim.lsp.config("jsonls", {})
      vim.lsp.enable({ "ts_ls", "lua_ls", "jsonls" })
    end
  }

}
