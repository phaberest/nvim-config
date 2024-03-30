return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          replace = 'gsc',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsh',
          update_n_lines = 'gsn',

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      }

      require('mini.splitjoin').setup()

      require('mini.pairs').setup()

      require('mini.comment').setup()

      require('mini.indentscope').setup {
        symbol = '▏', -- ▏│
        options = { try_as_border = true },
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'alpha',
          -- Add other file types you want to exclude here
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      require('mini.bufremove').setup {
        silent = true,
      }

      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<S-Left>',
          right = '<S-Right>',
          down = '<S-Down>',
          up = '<S-Up>',

          -- Move current line in Normal mode
          line_left = '<S-Left>',
          line_right = '<S-Right>',
          line_down = '<S-Down>',
          line_up = '<S-Up>',
        },
      }

      require('mini.statusline').setup {
        content = {
          active = function()
            -- show when recording a macro
            MiniStatusline.section_macro = function(args)
              if MiniStatusline.is_truncated(args.trunc_width) then
                return ''
              end

              local reg = vim.fn.reg_recording()
              return reg == '' and reg or 'REC @' .. reg
            end

            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 9000 }
            local spell = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
            local git = MiniStatusline.section_git { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local searchcount = MiniStatusline.section_searchcount { trunc_width = 75 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local macro = MiniStatusline.section_macro { trunc_width = 120 }
            local navic = require('nvim-navic').get_location()
            local spaces = function()
              local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { buf = 0 })
              return 'SPC:' .. shiftwidth
            end

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode, spell } },
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { navic } },
              '%=',
              { hl = 'MiniStatuslineModeCommand', strings = { macro } },
              { hl = 'MoreMsg', strings = { searchcount } },
              { hl = 'MiniStatuslineFilename', strings = { diagnostics } },
              { hl = mode_hl, strings = { spaces(), fileinfo } },
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
            }
          end,
        },
        use_icons = true,
        set_vim_settings = false, -- needed to keep statusline across windows
      }

      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'n', keys = '<Leader>a', desc = '+[A]I' },
          { mode = 'n', keys = '<Leader>b', desc = '+[B]uffers' },
          { mode = 'n', keys = '<Leader>c', desc = '+[C]ode' },
          { mode = 'n', keys = '<Leader>cs', desc = '+Snippets' },
          { mode = 'n', keys = '<Leader>d', desc = '+[D]ocument' },
          { mode = 'n', keys = '<Leader>s', desc = '+[S]earch' },
          { mode = 'n', keys = '<Leader>f', desc = '+[F]ind' },
          { mode = 'n', keys = '<Leader>g', desc = '+[G]it(hub)' },
          { mode = 'n', keys = '<Leader>w', desc = '+[W]orkspace' },
          { mode = 'n', keys = '<Leader>r', desc = '+[R]efactoring' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },

        window = {
          delay = 100,
          config = { anchor = 'NE', row = 'auto', col = 'auto', width = '80' },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
