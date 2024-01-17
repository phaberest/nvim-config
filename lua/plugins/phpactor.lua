return {
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    build = function()
      require("phpactor.handler.update")()
    end,
    opts = {
      install = {
        bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
      },
      lspconfig = {
        enabled = true,
        options = {
          init_options = {
            ["worse_reflection.stub_dir"] = "%application_root%/vendor/jetbrains/phpstorm-stubs",
            -- ["language_server_phpstan.enabled"] = true,
            -- ["phpunit.enabled"] = true,
          },
        },
      },
    },
    config = function(_, opts)
      local phpactor = require("phpactor")
      phpactor.setup(opts)
    end,
    keys = {
      {
        "<leader>cp",
        desc = "phpactor",
      },
      {
        "<leader>cpI",
        function()
          require("phpactor").rpc("import_missing_classes", {})
        end,
        desc = "Import missing classes",
      },
      {
        "<leader>cpm",
        function()
          require("phpactor").rpc("context_menu", {})
        end,
        desc = "Open Context Menu",
      },
      {
        "<leader>cpi",
        function()
          require("phpactor").rpc("import_class", {})
        end,
        desc = "Import Class",
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       phpactor = {
  --         init_options = {
  --           ["language_server_phpstan.bin"] = "/Users/phaberest/.composer/vendor/bin/phpstan",
  --           ["language_server_php_cs_fixer.enabled"] = true,
  --           ["language_server_phpstan.enabled"] = true,
  --           ["language_server_php_cs_fixer.bin"] = "/Users/phaberest/.composer/vendor/bin/php-cs-fixer",
  --           ["language_server_php_cs_fixer.show_diagnostics"] = true,
  --           ["phpunit.enabled"] = true,
  --           ["completion.dedupe"] = true,
  --           ["completion.dedupe_match_fqn"] = true,
  --           ["composer.autoloader_path"] = { "%project_root%/vendor/autoload.php" },
  --           ["indexer.exclude_patterns"] = {
  --             "/vendor/**/Tests/**/*",
  --             "/vendor/**/tests/**/*",
  --             "/.var/cache/**/*",
  --             "/var/cache/**/*",
  --             "/vendor-bin/**/vendor/php-stubs/wordpress-stubs/wordpress-stubs.php",
  --           },
  --           ["indexer.stub_paths"] = {
  --             "%project_root%/_ide_helper.php",
  --             "%project_root%/_ide_helper_models.php",
  --             "%project_root%/vendor-bin/phpstan/vendor",
  --             "%project_root%/vendor-bin/phpstan/vendor",
  --             "%project_root%/vendor-bin/stubs/vendor",
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
