-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- +---------------------------------------------------------+
-- |                         Python                          |
-- +---------------------------------------------------------+
local set = vim.keymap.set

set("n", "<leader>rr", function()
  local filetype = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local cmd
  if filetype == "python" then
    cmd = 'echo "Running file: ' .. file .. '" && python3 ' .. vim.fn.shellescape(file)
  else
    print("Unsupported filetype: " .. filetype)
    return
  end

  Snacks.terminal(cmd, { cwd = LazyVim.root(), auto_close = false, interactive = false })
  print(LazyVim.root())
end, { desc = "Run current file in terminal" })

-- +---------------------------------------------------------+
-- |                    Gigachad comments                    |
-- +---------------------------------------------------------+
set({ "n", "v" }, "gcC", "<Cmd>CBllbox10<CR>", { desc = "Comment box", noremap = true, silent = true })

-- +---------------------------------------------------------+
-- |                           DAP                           |
-- +---------------------------------------------------------+

local function map_dbg_keys()
  local dap = require("dap")
  vim.keymap.set("n", "<Down>", dap.step_over, { buffer = true, desc = "DAP Step Over" })
  vim.keymap.set("n", "<Right>", dap.step_into, { buffer = true, desc = "DAP Step Into" })
  vim.keymap.set("n", "<Left>", dap.step_out, { buffer = true, desc = "DAP Step Out" })
  vim.keymap.set("n", "<Up>", dap.restart_frame, { buffer = true, desc = "DAP Restart Frame" })
end

local function unmap_dbg_keys()
  vim.keymap.del("n", "<Down>", { buffer = true })
  vim.keymap.del("n", "<Right>", { buffer = true })
  vim.keymap.del("n", "<Left>", { buffer = true })
  vim.keymap.del("n", "<Up>", { buffer = true })
end

-- Register listeners only after nvim-dap has loaded, not at startup
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data ~= "nvim-dap" then
      return
    end
    local dap = require("dap")
    dap.listeners.after.event_initialized["custom_keymaps"] = map_dbg_keys
    dap.listeners.after.event_terminated["custom_keymaps"] = unmap_dbg_keys
    dap.listeners.after.event_exited["custom_keymaps"] = unmap_dbg_keys
  end,
})
