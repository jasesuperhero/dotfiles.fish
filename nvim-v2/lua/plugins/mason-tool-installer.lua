return {
  -- auto-install missing linters & formatters
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  version = false,
  event = { "VeryLazy" },
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  opts = User.table.merge_options {
    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = true,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = false,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay
  },
  config = function(_, opts)
    require("mason-tool-installer").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsStartingInstall",
      callback = function()
        vim.schedule(
          function()
            User.info("Starting install the packages", {
              title = "Mason Tools Installer",
              once = true,
            })
          end
        )
      end,
    })

    -- clean unused & install missing
    vim.defer_fn(vim.cmd.MasonToolsInstall, 3000)
  end,
}
