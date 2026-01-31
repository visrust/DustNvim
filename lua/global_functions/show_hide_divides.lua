-- Global Window Management Functions with Error Handling
-- Place this in your Neovim config

-- Function 1: Close window under cursor (Normal/Terminal mode only)
_G.close_window_under_cursor = function()
  -- Check if we're in normal or terminal mode
  local mode = vim.api.nvim_get_mode().mode
  if not (mode == 'n' or mode == 't' or mode == 'nt') then
    vim.notify("Function only works in Normal or Terminal mode", vim.log.levels.WARN)
    return
  end
  
  local ok, err = pcall(function()
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    
    -- Check if this is the only window
    local wins = vim.api.nvim_list_wins()
    local visible_wins = vim.tbl_filter(function(w)
      return vim.api.nvim_win_get_config(w).relative == ""
    end, wins)
    
    if #visible_wins <= 1 then
      vim.notify("Can't close the main window", vim.log.levels.WARN)
      return
    end
    
    -- Check if buffer is a special type (terminal, oil, etc.)
    local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    
    -- List of special filetypes that represent "main buffers"
    local special_types = {
      'terminal',
      'oil',
      'netrw',
      'help',
    }
    
    -- Check if it's a terminal buffer
    if buftype == 'terminal' then
      vim.notify("Main buffer can't be closed", vim.log.levels.WARN)
      return
    end
    
    -- Check for special filetypes
    for _, ftype in ipairs(special_types) do
      if filetype == ftype then
        vim.notify("Main buffer can't be closed", vim.log.levels.WARN)
        return
      end
    end
    
    -- Check if buffer has a special name pattern (for oil.nvim, etc.)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match("^oil://") or bufname:match("^term://") then
      vim.notify("Main buffer can't be closed", vim.log.levels.WARN)
      return
    end
    
    -- Close the window
    vim.api.nvim_win_close(win, false)
    vim.notify("Window closed", vim.log.levels.INFO)
  end)
  
  if not ok then
    vim.notify("Error closing window: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- Function 2: Toggle visibility of non-editor windows
_G.toggle_other_windows = function()
  local ok, err = pcall(function()
    -- Store state in a global variable
    if _G._hidden_windows == nil then
      _G._hidden_windows = {}
    end
    
    local current_win = vim.api.nvim_get_current_win()
    local all_wins = vim.api.nvim_list_wins()
    
    -- Filter for normal windows (not floating)
    local normal_wins = vim.tbl_filter(function(w)
      return vim.api.nvim_win_get_config(w).relative == ""
    end, all_wins)
    
    -- If we have only one window, nothing to hide
    if #normal_wins <= 1 and #_G._hidden_windows == 0 then
      vim.notify("No other windows to hide", vim.log.levels.WARN)
      return
    end
    
    -- Check if we're restoring or hiding
    if #_G._hidden_windows > 0 then
      -- Restore hidden windows
      local restored_count = 0
      for _, win_info in ipairs(_G._hidden_windows) do
        local restore_ok = pcall(function()
          -- Check if buffer still exists
          if vim.api.nvim_buf_is_valid(win_info.buf) then
            -- Create a new split
            if win_info.position == 'left' or win_info.position == 'right' then
              vim.cmd('vsplit')
            else
              vim.cmd('split')
            end
            
            local new_win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(new_win, win_info.buf)
            restored_count = restored_count + 1
          end
        end)
      end
      
      -- Clear hidden windows
      _G._hidden_windows = {}
      
      -- Return to original window
      if vim.api.nvim_win_is_valid(current_win) then
        vim.api.nvim_set_current_win(current_win)
      end
      
      vim.notify(string.format("Restored %d window(s)", restored_count), vim.log.levels.INFO)
    else
      -- Hide other windows
      local hidden_count = 0
      
      for _, win in ipairs(normal_wins) do
        if win ~= current_win then
          local hide_ok = pcall(function()
            local buf = vim.api.nvim_win_get_buf(win)
            local win_config = vim.api.nvim_win_get_config(win)
            
            -- Determine position (simplified)
            local position = 'other'
            local win_pos = vim.api.nvim_win_get_position(win)
            local cur_pos = vim.api.nvim_win_get_position(current_win)
            
            if win_pos[2] < cur_pos[2] then
              position = 'left'
            elseif win_pos[2] > cur_pos[2] then
              position = 'right'
            elseif win_pos[1] < cur_pos[1] then
              position = 'top'
            else
              position = 'bottom'
            end
            
            -- Store window info
            table.insert(_G._hidden_windows, {
              buf = buf,
              position = position,
            })
            
            -- Close the window
            vim.api.nvim_win_close(win, false)
            hidden_count = hidden_count + 1
          end)
        end
      end
      
      vim.notify(string.format("Hidden %d window(s)", hidden_count), vim.log.levels.INFO)
    end
  end)
  
  if not ok then
    vim.notify("Error toggling windows: " .. tostring(err), vim.log.levels.ERROR)
    -- Reset state on error
    _G._hidden_windows = {}
  end
end
vim.keymap.set({'n', 't'}, '<M-q>', close_window_under_cursor, { desc = 'Close window under cursor' })
