return {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermNew', 'FloatermToggle', 'FloatermNext', 'FloatermPrev', 'FloatermLast', 'FloatermFirst' },
    --stylua: ignore
    keys = {
      { "<leader>gg",  "<cmd>FloatermNew --name=lazygitroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> lazygit<CR>",        desc = "Lazygit (root dir)" },
      { "<leader>gG",  "<cmd>FloatermNew --name=lazygitbuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer> lazygit<CR>",    desc = "Lazygit (cwd)" },

      { "<leader>gl",  "<cmd>FloatermNew --name=lazydocker --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> lazydocker<CR>",      desc = "Lazydocker" },
      { "<leader>cen", "<cmd>FloatermNew --name=node --opener=edit --titleposition=center --wintype=split --height=0.35 node<CR>",                            desc = "Node" },
      { "<leader>cep", "<cmd>FloatermNew --name=python --opener=edit --titleposition=center --wintype=split --height=0.35 python<CR>",                        desc = "Python" },
      { "<leader>cel", "<cmd>FloatermNew --name=python --opener=edit --titleposition=center --wintype=split --height=0.35 lua<CR>",                           desc = "Lua" },
      { "<leader>cer", "<cmd>FloatermNew --name=rails_c --opener=edit --titleposition=center --wintype=split --height=0.35 bin/rails c<CR>",                  desc = "Lua" },
      { "<S-Right>",   "<Esc><Esc><cmd>FloatermNext<CR>",                                                                                                     mode = { "t" }, desc = "Next Terminal" },
      { "<S-Left>",    "<Esc><Esc><cmd>FloatermPrev<CR>",                                                                                                     mode = { "t" }, desc = "Prev Terminal" },
      { "<A-Right>",   "<Esc><Esc><cmd>FloatermLast<CR>",                                                                                                     mode = { "t" }, desc = "Last Terminal" },
      { "<A-Left>",    "<Esc><Esc><cmd>FloatermFirst<CR>",                                                                                                    mode = { "t" }, desc = "First Terminal" },
      { [[<c-\>]],     "<cmd>FloatermToggle<cr>",                                                                                                             mode = { "n",   "t" }, desc = "Toggle Terminal" },
      { "<leader>flf", "<cmd>FloatermNew --name=floatroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root><cr>",                  desc = "Floating (root dir)" },
      { "<leader>flF", "<cmd>FloatermNew --name=floatbuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer><cr>",              desc = "Floating (cwd)" },
      { "<leader>fls", "<cmd>FloatermNew --name=splitroot --opener=edit --titleposition=center --height=0.35 --wintype=split --cwd=<root><cr>",               desc = "Split (root dir)" },
      { "<leader>flS", "<cmd<M-Bslash>>FloatermNew --name=splitbuffer --opener=edit --titleposition=center --height=0.35 --wintype=split --cwd=<buffer><cr>", desc = "Split (cwd)" },
    },
}
