-- Global function to resize the current window
function _G.smart_resize(key)
  local curr_win = vim.api.nvim_get_current_win()
  local curr_width = vim.api.nvim_win_get_width(curr_win)
  local curr_height = vim.api.nvim_win_get_height(curr_win)

  local step = 3 -- change this for bigger/smaller increments

  if key == "Up" then
    vim.api.nvim_win_set_height(curr_win, curr_height + step)
  elseif key == "Down" then
    vim.api.nvim_win_set_height(curr_win, math.max(curr_height - step, 1))
  elseif key == "Left" then
    vim.api.nvim_win_set_width(curr_win, math.max(curr_width - step, 1))
  elseif key == "Right" then
    vim.api.nvim_win_set_width(curr_win, curr_width + step)
  end
end


local opts = { noremap = true, silent = true }

-- Normal mode
vim.keymap.set("n", "<C-Up>",    function() _G.smart_resize("Up") end, opts)
vim.keymap.set("n", "<C-Down>",  function() _G.smart_resize("Down") end, opts)
vim.keymap.set("n", "<C-Left>",  function() _G.smart_resize("Left") end, opts)
vim.keymap.set("n", "<C-Right>", function() _G.smart_resize("Right") end, opts)

-- Terminal mode (also works inside toggleterm)
vim.keymap.set("t", "<C-Up>",    function() _G.smart_resize("Up") end, opts)
vim.keymap.set("t", "<C-Down>",  function() _G.smart_resize("Down") end, opts)
vim.keymap.set("t", "<C-Left>",  function() _G.smart_resize("Left") end, opts)
vim.keymap.set("t", "<C-Right>", function() _G.smart_resize("Right") end, opts)
