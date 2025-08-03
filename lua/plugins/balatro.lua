return {
  {
    "balatro-ascii",
    dir = "~/.config/nvim/lua/balatro",
    lazy = false,
    config = function()
      require("balatro").show()
    end,
  },
}
