return {
  {
    "folke/sidekick.nvim",
    opts = function()
      require("sidekick.nes").disable()
    end,
  },
}
