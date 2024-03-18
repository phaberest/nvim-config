return {
  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'deepseek-coder:6.7b', -- The default model to use.
      display_mode = 'float', -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      init = function()
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
      end,
      -- Function to initialize Ollama
      command = 'curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body',
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      list_models = '<function>', -- Retrieves a list of model names
      debug = false, -- Prints errors and the command which is run.
    },
    keys = {
      {
        '<leader>au',
        mode = { 'n', 'x' },
        '<cmd>Gen<CR>',
        desc = 'Use the force deepseeker',
      },
    },
  },

  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      -- Default AI popup type
      popup_type = 'popup',
      -- An alternative way to set your API key
      openai_api_key = vim.env.OPENAI_API_KEY,
      -- ChatGPT Model
      openai_model_id = 'gpt-3.5-turbo',
      -- Send code as well as diagnostics
      context = true,
      -- Set your preferred language for the response
      language = 'english',
      -- Default search engine, can be overridden by passing an option to WtfSeatch
      search_engine = 'google',
      -- Callbacks
      hooks = {
        request_started = nil,
        request_finished = nil,
      },
      -- Add custom colours
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
    keys = {
      {
        'gw',
        mode = { 'n', 'x' },
        function()
          require('wtf').ai()
        end,
        desc = 'Debug diagnostic with AI',
      },
      {
        mode = { 'n' },
        'gW',
        function()
          require('wtf').search()
        end,
        desc = 'Search diagnostic with Google',
      },
    },
  },
}
