-- Close the window under the cursor safely
-- Currently not in use
function _G.close_current_win()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  
  -- Only allow closing if it's a normal window or toggleterm float
  local filetype = vim.bo[buf].filetype
  local config = vim.api.nvim_win_get_config(win)
  
  -- Check: float (relative ~= "") or any regular window
  if config.relative ~= "" or vim.api.nvim_win_get_option(win, "modifiable") then
    vim.api.nvim_win_close(win, true)
  end
end

-- Map Alt-q in normal & terminal mode
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<M-q>", _G.close_current_win, opts)
vim.keymap.set("t", "<M-q>", _G.close_current_win, opts)
