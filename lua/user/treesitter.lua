return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  version = false,
  build = function()
    pcall(require("nvim-treesitter.install").update { with_sync = true })
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
        local configs = require "nvim-treesitter.configs"
        for name, fn in pairs(move) do
          if name:find "goto" == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                for key, query in pairs(config or {}) do
                  if q == query and key:find "[%]%[][cC]" then
                    vim.cmd("normal! " .. key)
                    return
                  end
                end
              end
              return fn(q, ...)
            end
          end
        end
      end,
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
    -- Show context of the current function
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "VeryLazy",
      enabled = true,
      opts = { mode = "cursor" },
      keys = {
        {
          "<leader>lc",
          function()
            local tsc = require "treesitter-context"
            tsc.toggle()
          end,
          desc = "Toggle Treesitter Context",
        },
      },
    },
    -- Automatically add closing tags for HTML and JSX
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      opts = {},
    },
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "lua",
        "python",
        "typescript",
        "regex",
        "typescript",
        "php",
        "bash",
        "markdown",
        "markdown_inline",
        "kdl",
        "sql",
        "org",
        "svelte",
      },

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-backspace>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ii"] = "@conditional.inner",
            ["ai"] = "@conditional.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["at"] = "@comment.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          -- goto_next = {
          --   [']i'] = "@conditional.inner",
          -- },
          -- goto_previous = {
          --   ['[i'] = "@conditional.inner",
          -- }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>j"] = "@parameter.*",
          },
          swap_previous = {
            ["<leader>k"] = "@parameter.*",
          },
        },
      },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
          "html",
          "xml",
          "php",
          "svelte",
          "vue",
          "javascriptreact",
          "javascript",
          "typescript",
          "astro",
          "smarty",
        },
      },
    }
  end,
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require "nvim-treesitter.query_predicates"
  end,
}
