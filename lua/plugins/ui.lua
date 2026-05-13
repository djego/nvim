return {
  -- Indent guides: línea vertical en el bloque actual
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = { animation = function() return 0 end },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "mason", "NvimTree", "Trouble", "dashboard" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
    config = function(_, opts) require("mini.indentscope").setup(opts) end,
  },

  -- Bufferline: pestañas visuales con iconos
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLinePick<cr>",        desc = "Pick buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count) return "(" .. count .. ")" end,
        offsets = {
          { filetype = "NvimTree", text = "Files", separator = true, text_align = "left" },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
      },
    },
  },
}
