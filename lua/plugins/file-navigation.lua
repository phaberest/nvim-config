-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

return {
  {
    'otavioschwanck/arrow.nvim',
    opts = {
      show_icons = true,
      leader_key = ';',
      mappings = {
        edit = 'e',
        delete_mode = 'd',
        clear_all_items = 'C',
        toggle = 's',
        open_vertical = '|',
        open_horizontal = '\\',
        quit = 'q',
      },
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    config = function()
      local neotree = require 'neo-tree'

      neotree.setup {
        close_if_last_window = true,
        sort_case_insensitive = true,
        default_component_configs = {
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '✖',
              renamed = '󰁕',
              untracked = '',
              ignored = '',
              unstaged = '󰄱',
              staged = '',
              conflict = '',
            },
          },
        },
        event_handlers = {
          {
            event = 'file_opened',
            handler = function(file_path)
              -- auto close
              -- vimc.cmd("Neotree close")
              -- OR
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
        commands = {
          parent_or_close = function(state)
            local node = state.tree:get_node()
            if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
            end
          end,
          child_or_open = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' or node:has_children() then
              if not node:is_expanded() then -- if unexpanded, expand
                state.commands.toggle_node(state)
              else -- if expanded and has children, seleect the next child
                require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
              end
            else -- if not a directory just open it
              state.commands.open(state)
            end
          end,
          copy_selector = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ['BASENAME'] = modify(filename, ':r'),
              ['EXTENSION'] = modify(filename, ':e'),
              ['FILENAME'] = filename,
              ['PATH (CWD)'] = modify(filepath, ':.'),
              ['PATH (HOME)'] = modify(filepath, ':~'),
              ['PATH'] = filepath,
              ['URI'] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ''
            end, vim.tbl_keys(vals))
            if vim.tbl_isempty(options) then
              vim.notify('No values to copy', vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = 'Choose to copy to clipboard:',
              format_item = function(item)
                return ('%s: %s'):format(item, vals[item])
              end,
            }, function(choice)
              local result = vals[choice]
              if result then
                vim.notify(('Copied: `%s`'):format(result))
                vim.fn.setreg('+', result)
              end
            end)
          end,
        },
        window = {
          position = 'right',
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = false, -- disable space until we figure out which-key disabling
            ['<cr>'] = 'open',
            ['<esc>'] = 'cancel',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
            ['L'] = 'focus_preview',
            ['\\'] = 'open_split',
            ['|'] = 'open_vsplit',
            ['t'] = 'open_tabnew',
            ['w'] = 'open_with_window_picker',
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            ['Y'] = 'copy_selector',
            ['h'] = 'parent_or_close',
            ['l'] = 'child_or_open',
            ['a'] = {
              'add',
              config = {
                show_path = 'relative',
              },
            },
            ['A'] = {
              'add_directory',
              config = {
                show_path = 'relative',
              },
            },
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy',
            ['m'] = 'move',
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
            ['i'] = 'show_file_details',
          },
        },
        sources = { 'filesystem', 'git_status' },
        source_selector = {
          winbar = true,
          content_layout = 'center',
          sources = {
            { source = 'filesystem', display_name = 'File' },
            { source = 'git_status', display_name = 'Git' },
            { source = 'diagnostics', display_name = 'Diagnostic' },
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {
              '.gitignore',
              '.env',
            },
            never_show = {
              '.git',
              'node_modules',
            },
            never_show_by_pattern = {},
          },
          use_libuv_file_watcher = true,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          hijack_netrw_behavior = 'open_current',
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              ['#'] = 'fuzzy_sorter',
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['og'] = { 'order_by_git_status', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ['<C-j>'] = 'move_cursor_down',
              ['<C-k>'] = 'move_cursor_up',
            },
          },
        },
      }
    end,
  },
}
