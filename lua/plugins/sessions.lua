-- Simple lua plugin for automated session management
return {
  'folke/persistence.nvim',
  event = 'VimEnter',
  cmd = {
    'SessionSave',
    'SessionStart',
    'SessionToggle',
    'SessionLoad',
    'SessionLoadLast',
    'SessionLoadFromFile',
    'SessionLoadDelete',
  },
  opts = {
    save_dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'), -- directory where session files are saved
    options = vim.opt_global.sessionoptions:get(),
    silent = false, -- silent nvim message when sourcing session file
    use_git_branch = true, -- create session files based on the branch of the git enabled repository
    autosave = true, -- automatically save session files when exiting Neovim
    autoload = false, -- automatically load the session for the cwd on Neovim startup
  },

  -- stylua: ignore
  keys = {
    {'<leader>qs', function() require('persistence').load() end, desc = 'Restore Session',},
    {'<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore Last Session',},
    {'<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Current Session",},
  },
  init = function()
    vim.g.started_with_stdin = false
    vim.api.nvim_create_autocmd('StdinReadPre', {
      group = vim.api.nvim_create_augroup('phab_persistence', {}),
      callback = function()
        vim.g.started_with_stdin = true
      end,
    })

    local disabled_dirs = {
      vim.env.TMPDIR or '/tmp',
      '/private/tmp',
    }
    vim.api.nvim_create_autocmd('VimEnter', {
      group = 'phab_persistence',
      once = true,
      nested = true,
      callback = function()
        local cwd = vim.loop.cwd() or vim.fn.getcwd()
        if cwd == nil or vim.fn.argc() > 0 or vim.g.started_with_stdin or vim.env.GIT_EXEC_PATH ~= nil then
          require('persistence').stop()
          return
        end
        for _, path in pairs(disabled_dirs) do
          if cwd:sub(1, #path) == path then
            require('persistence').stop()
            return
          end
        end

        -- Close all floats before loading a session. (e.g. Lazy.nvim)
        for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.api.nvim_win_get_config(win).zindex then
            vim.api.nvim_win_close(win, false)
          end
        end

        -- Manually exclude NeoTree from the session
        -- This is a workaround since persistence.nvim does not directly support excluding specific plugins
        for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local bufname = vim.api.nvim_buf_get_name(buf)
          if string.match(bufname, 'NeoTree') then
            vim.api.nvim_win_close(win, false)
          end
        end
      end,
    })
  end,
}
