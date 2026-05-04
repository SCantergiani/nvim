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
set({ "n", "v" }, "gcb", "<Cmd>CBllbox10<CR>", { desc = "Comment box", noremap = true, silent = true })

-- +---------------------------------------------------------+
-- |                           DAP                           |
-- +---------------------------------------------------------+
local dap = require("dap")

-- Helper: set buffer-local keymap
local function map_dbg_keys()
  vim.keymap.set("n", "<Down>", dap.step_over, { buffer = true, desc = "DAP Step Over" })
  vim.keymap.set("n", "<Right>", dap.step_into, { buffer = true, desc = "DAP Step Into" })
  vim.keymap.set("n", "<Left>", dap.step_out, { buffer = true, desc = "DAP Step Out" })
  vim.keymap.set("n", "<Up>", dap.restart_frame, { buffer = true, desc = "DAP Restart Frame" })
end

-- Helper: remove buffer-local keymaps
local function unmap_dbg_keys()
  vim.keymap.del("n", "<Down>", { buffer = true })
  vim.keymap.del("n", "<Right>", { buffer = true })
  vim.keymap.del("n", "<Left>", { buffer = true })
  vim.keymap.del("n", "<Up>", { buffer = true })
end

-- Set keymaps after DAP starts
dap.listeners.after.event_initialized["custom_keymaps"] = function()
  map_dbg_keys()
end

-- Unset keymaps after DAP ends
dap.listeners.after.event_terminated["custom_keymaps"] = function()
  unmap_dbg_keys()
end
dap.listeners.after.event_exited["custom_keymaps"] = function()
  unmap_dbg_keys()
end
