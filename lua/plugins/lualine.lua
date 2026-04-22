return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "christopher-francisco/tmux-status.nvim" },
  opts = function(_, opts)
    -- Add tmux windows to the middle section (lualine_c)
    table.insert(opts.sections.lualine_c, {
      require("tmux-status").tmux_windows,
      cond = require("tmux-status").show,
      padding = { left = 3 },
    })

    -- Replace the default time in lualine_z with tmux session
    -- (or you can add it alongside the time)
    opts.sections.lualine_z = {
      {
        require("tmux-status").tmux_session,
        cond = require("tmux-status").show,
        padding = { left = 1, right = 1 },
      },
    }

    return opts
  end,
}
