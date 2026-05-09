return {
  -- Auto-cierre de ()[]{}""''
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function() require("mini.pairs").setup() end,
  },

  -- Surround: saiw" → "word", sd" → word, sr"' → 'word'
  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", mode = { "n", "v" } },
      "sd",
      "sr",
    },
    config = function() require("mini.surround").setup() end,
  },

  -- Comentar: gcc línea, gc en visual
  {
    "echasnovski/mini.comment",
    keys = {
      { "gc",  mode = { "n", "v" } },
      { "gcc", mode = "n" },
    },
    config = function() require("mini.comment").setup() end,
  },
}
