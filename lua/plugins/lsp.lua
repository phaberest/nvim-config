-- lsp servers
return {
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
        },
      })
    end,
  },

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

  {
    "aznhe21/actions-preview.nvim",
    event = "LazyFile",
    -- stylua: ignore
    keys = {
      { "ga", function() require("actions-preview").code_actions() end, desc = "Code Action Preview", mode = { "n", "v" } },
    },
    opts = {},
  },

  {
    "kosayoda/nvim-lightbulb",
    event = "LazyFile",
    opts = {
      autocmd = { enabled = true, events = { "CursorHold", "CursorHoldI" } },
    },
  },
}
