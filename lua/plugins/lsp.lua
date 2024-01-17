-- lsp servers
return {
  -- {
  --   -- LSP Configuration
  --   -- https://github.com/neovim/nvim-lspconfig
  --   "neovim/nvim-lspconfig",
  --   lazy = false,
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     -- LSP Management
  --     -- https://github.com/williamboman/mason.nvim
  --     { "williamboman/mason.nvim" },
  --     -- https://github.com/williamboman/mason-lspconfig.nvim
  --     { "williamboman/mason-lspconfig.nvim" },
  --
  --     -- Useful status updates for LSP
  --     -- https://github.com/j-hui/fidget.nvim
  --     { "j-hui/fidget.nvim", opts = {} },
  --
  --     -- Additional lua configuration, makes nvim stuff amazing!
  --     -- https://github.com/folke/neodev.nvim
  --     { "folke/neodev.nvim" },
  --   },
  --   config = function()
  --     local language_servers = {
  --       "astro",
  --       "dockerls",
  --       "docker_compose_language_service",
  --       "eslint",
  --       "emmet_ls",
  --       "graphql",
  --       "html",
  --       "htmx",
  --       "jsonls",
  --       "lua_ls",
  --       "marksman",
  --       "phpactor",
  --       "prismals",
  --       "pyright",
  --       "rust_analyzer",
  --       "sqlls",
  --       "svelte",
  --       "tailwindcss",
  --       "terraformls",
  --       "tsserver",
  --       "volar",
  --       "lemminx",
  --       "yamlls",
  --     }
  --
  --     require("mason").setup()
  --     require("mason-lspconfig").setup({
  --       -- Update this list to the language servers you need installed
  --       ensure_installed = language_servers,
  --     })
  --
  --     local lspconfig = require("lspconfig")
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  --     -- local lsp_attach = function(client, bufnr)
  --     --   -- Create your keybindings here...
  --     -- end
  --
  --     -- Call setup on each LSP server
  --     for _, lsp in ipairs(language_servers) do
  --       local opts = {
  --         capabilities = capabilities,
  --         flags = {
  --           debounce_text_changes = 150,
  --         },
  --       }
  --
  --       local extend, user_opts = pcall(require, "lsp-config." .. lsp)
  --
  --       if extend then
  --         opts = vim.tbl_deep_extend("force", opts, user_opts)
  --       end
  --
  --       lspconfig[lsp].setup(opts)
  --     end
  --
  --     -- require("mason-lspconfig").setup_handlers({
  --     --   function(server_name)
  --     --     lspconfig[server_name].setup({
  --     --       -- on_attach = lsp_attach,
  --     --       capabilities = capabilities,
  --     --     })
  --     --   end,
  --     -- })
  --
  --     -- Lua LSP settings
  --     lspconfig.lua_ls.setup({
  --       settings = {
  --         Lua = {
  --           diagnostics = {
  --             -- Get the language server to recognize the `vim` global
  --             globals = { "vim" },
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {
        eslint = {},
        tsserver = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        lua_ls = {},
        phpactor = {},
        svelte = {},
        astro = {},
        dockerls = {},
        docker_compose_language_service = {},
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",
          "html",
          "cssls",
          "jsonls",
          "tailwindcss",
          "svelte",
          "lua_ls",
          "emmet_ls",
          "prismals",
          "rust_analyzer",
          "astro",
          "phpactor",
          "dockerls",
          "docker_compose_language_service",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- override lua_ls server setup
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,

          -- override tsserver server setup
          -- ["tsserver"] = function()
          --   require("lspconfig").tsserver.setup({
          --     capabilities = capabilities,
          --     init_options = {
          --       preferences = {
          --         disableSuggestions = true,
          --       },
          --     },
          --   })
          -- end,

          -- fix astro completion deleting words
          ["astro"] = function()
            require("lspconfig").astro.setup({
              capabilities = capabilities,
              settings = {
                astro = {
                  disableResolveCompletionItem = true,
                },
              },
            })
          end,

          -- override cssls server setup
          -- ["cssls"] = function()
          --   require("lspconfig").cssls.setup({
          --     capabilities = capabilities,
          --     settings = {
          --       css = {
          --         validate = false,
          --       },
          --     },
          --   })
          -- end,
        },
      })
    end,
  },
  -- {
  -- "neovim/nvim-lspconfig",
  -- dependencies = {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true, inlay_hints = { enabled = true } } },
    keys = {
      { "<leader>cln", "<cmd>Navbuddy<cr>", desc = "Lsp Navigation" },
    },
  },
  -- },
  -- init = function()
  --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --
  --   -- move cl to cli
  --   keys[#keys + 1] = { "<leader>cl", false }
  --   keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "LspInfo" }
  --
  --   -- add more lsp keymaps
  --   keys[#keys + 1] = { "<leader>cla", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" }
  --   keys[#keys + 1] = { "<leader>clr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" }
  --   keys[#keys + 1] = {
  --     "<leader>cll",
  --     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
  --     desc = "List Folders",
  --   }
  --   keys[#keys + 1] = { "<leader>clh", vim.lsp.codelens.run, desc = "Run Code Lens" }
  --   keys[#keys + 1] = { "<leader>cld", vim.lsp.codelens.refresh, desc = "Refresh Code Lens" }
  --   keys[#keys + 1] = { "<leader>cls", "<cmd>LspRestart<cr>", desc = "Restart Lsp" }
  --
  --   require("which-key").register({
  --     ["<leader>cl"] = { name = "+lsp" },
  --   })
  -- end,
  -- opts = {
  --   diagnostics = { virtual_text = { prefix = "icons" } },
  --   capabilities = {
  --     workspace = {
  --       didChangeWatchedFiles = {
  --         dynamicRegistration = false,
  --       },
  --     },
  --   },
  --   ---@type lspconfig.options
  --   ---@diagnostic disable: missing-fields
  --   servers = {
  --     bashls = {},
  --     cssls = {},
  --     html = {},
  --     svelte = {},
  --     astro = {},
  --     lua_ls = {
  --       single_file_support = true,
  --       ---@type lspconfig.settings.lua_ls
  --       settings = {
  --         Lua = {
  --           workspace = {
  --             checkThirdParty = false,
  --           },
  --           completion = {
  --             workspaceWord = true,
  --             callSnippet = "Both",
  --           },
  --           misc = {
  --             parameters = {
  --               "--log-level=trace",
  --             },
  --           },
  --           hover = { expandAlias = false },
  --           hint = {
  --             enable = true,
  --             setType = false,
  --             paramType = true,
  --             paramName = "Disable",
  --             semicolon = "Disable",
  --             arrayIndex = "Disable",
  --           },
  --           doc = {
  --             privateName = { "^_" },
  --           },
  --           type = {
  --             castNumberToInteger = true,
  --           },
  --           diagnostics = {
  --             disable = { "incomplete-signature-doc", "trailing-space" },
  --             -- enable = false,
  --             groupSeverity = {
  --               strong = "Warning",
  --               strict = "Warning",
  --             },
  --             groupFileStatus = {
  --               ["ambiguity"] = "Opened",
  --               ["await"] = "Opened",
  --               ["codestyle"] = "None",
  --               ["duplicate"] = "Opened",
  --               ["global"] = "Opened",
  --               ["luadoc"] = "Opened",
  --               ["redefined"] = "Opened",
  --               ["strict"] = "Opened",
  --               ["strong"] = "Opened",
  --               ["type-check"] = "Opened",
  --               ["unbalanced"] = "Opened",
  --               ["unused"] = "Opened",
  --             },
  --             unusedLocalExclude = { "_*" },
  --           },
  --           format = {
  --             enable = false,
  --             defaultConfig = {
  --               indent_style = "tab",
  --               indent_size = "4",
  --               continuation_indent_size = "4",
  --             },
  --           },
  --         },
  --       },
  --     },
  --     marksman = {},
  --     pyright = {},
  --     tsserver = {
  --       -- root_dir = function(...)
  --       --   return require("lspconfig.util").root_pattern(".git")(...)
  --       -- end,
  --       single_file_support = false,
  --       settings = {
  --         typescript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "literal",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = false,
  --             includeInlayVariableTypeHints = false,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --         },
  --         javascript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "all",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = true,
  --             includeInlayVariableTypeHints = true,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --         },
  --       },
  --     },
  --     vimls = {},
  --     yamlls = {
  --       settings = {
  --         yaml = {
  --           customTags = {
  --             "!reference sequence", -- necessary for gitlab-ci.yaml files
  --           },
  --         },
  --       },
  --     },
  --     phpactor = {},
  --   },
  --   setup = {},
  -- },
}
