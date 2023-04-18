return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerToggle",
    "OverseerOpen",
    "OverseerRun",
    "OverseerBuild",
    "OverseerClose",
    "OverseerLoadBundle",
    "OverseerSaveBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerQuickAction",
    "OverseerTaskAction",
  },
  config = function() require("overseer").setup() end,
}
