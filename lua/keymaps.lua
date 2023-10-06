local utils = require "utils.keymaps-helpers"
local maps = utils.empty_map_table()

local sections = {
  d = { desc = " Debug" },
  f = { desc = "󰭎 Telescope" },
  g = { desc = "󰊢 Git" },
  l = { desc = " LSP" },
  r = { desc = " Refactor"},
  x = { desc = " Trouble" },
}

-- Standart --
-- Better window navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Navigate to the left split" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Navigate to the bottom split" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Navigate to the top split" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Navigate to the right split" }

-- Resize with arrows
maps.n["="] = { "<cmd>resize -2<cr>", desc = "Shrink window horizontally" }
maps.n["-"] = { "<cmd>resize +2<cr>", desc = "Increase window horizontally" }
maps.n["+"] = { "<cmd>vertical resize -2<cr>", desc = "Shrink window vertically" }
maps.n["_"] = { "<cmd>vertical resize +2<cr>", desc = "Increase window vertically" }
maps.n["<leader>="] = { "<C-w>=", desc = "Equalize windows" }

-- Splits
maps.n["|"] = { "<cmd>vs<cr>", desc = "Split vertically" }
maps.n["\\"] = { "<cmd>sp<cr>", desc = "Split horizontally" }
maps.n["<leader>q"] = { "<cmd>close<cr>", desc = "Close current split" }

-- Navigate buffers
maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }

-- Clear highlights
maps.n["<leader>h"] = { "<cmd>nohsearch<cr>", desc = "Clear highlights" }

-- Close buffer
maps.n["<leader>Q"] = { "<cmd>Bdelete!<cr>", desc = "Close buffer" }

-- Better paste
maps.v["p"] = { "P", desc = "Better paste" }

-- Terminal
maps.t["<esc>"] = { "<C-\\><C-n>", desc = "Exit terminal" }

-- Insert --
-- Press jj fast to ESC
maps.i["jj"] = { "<ESC>", desc = "Better escape" }

-- Visual --
-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "Indent to the left" }
maps.v[">"] = { ">gv", desc = "Indent to the right" }

-- Plugins --

-- NvimTree
maps.n["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" }

maps.n["<leader>f"] = sections.f
maps.n["<leader><leader>"] = { "<cmd>Telescope resume<cr>", desc = "Resume search" }
maps.n["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find files" }
maps.n["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", desc = "Find words" }
maps.n["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", desc = "Find words" }
maps.n["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find projects" }
maps.n["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Find buffers" }
maps.n["<leader>fd"] = { "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" }

-- Git
maps.n["<leader>g"] = sections.g
maps.n["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit" }
maps.n["<leader>gl"] = { "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "View Git blame" }
maps.n["<leader>gL"] = { "<cmd>lua require('gitsigns').blame_line { full = true }<cr>", desc = "View full Git blame" }
maps.n["<leader>gp"] = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Git hunk" }
maps.n["<leader>gh"] = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Git hunk" }
maps.n["<leader>gr"] = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset Git buffer" }
maps.n["<leader>gs"] = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Git hunk" }
maps.n["<leader>gS"] = { "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage Git buffer" }
maps.n["<leader>gu"] = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Unstage Git hunk" }
maps.n["<leader>gd"] = { "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "View Git diff" }
maps.n["]g"] = { "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Git hunk" }
maps.n["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous Git hunk" }

-- Comment
maps.n["<leader>/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", desc = "Toggle comment line" }
maps.v["<leader>/"] =
  { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "Toggle comment line" }

-- Dap
maps.n["<leader>d"] = sections.d
maps.n["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" }
maps.n["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" }
maps.n["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" }
maps.n["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" }
maps.n["<leader>dO"] = { "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" }
maps.n["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle REPL" }
maps.n["<leader>dl"] = { "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last" }
maps.n["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle Dap UI" }
maps.n["<leader>dt"] = { "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" }

-- Lsp
maps.n["<leader>l"] = sections.l
maps.n["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", desc = "Format file" }
maps.n["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" }
maps.n["<leader>ls"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature help" }
maps.n["<leader>ld"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Float diagnostic" }
maps.n["<leader>lq"] = { "<cmd>lua vim.diagnostic.setqflist()<cr>", desc = "Setqflist" }
maps.n["<leader>ll"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Setloclist" }
maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "Lsp info" }
maps.n["<leader>lj"] = { "<cmd>LspNextDiagnostic<cr>", desc = "Next diagnostic" }
maps.n["<leader>lk"] = { "<cmd>LspPreviousDiagnostic<cr>", desc = "Previous diagnostic" }
maps.n["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" }
maps.n["<leader>lb"] = { "<cmd>Navbuddy<cr>", desc = "Navbuddy"}
maps.n["<leader>fr"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find workspace symbols" }
maps.n["<leader>fR"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find workspace symbols" }

--- Refactor
maps.n["<leader>r"] = sections.r
maps.n["<leader>re"] = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", desc = "Extract function" }
maps.n["<leader>rf"] = { "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>", desc = "Extract to file" }

maps.x["<leader>rv"] = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", desc = "Extract variable" }

maps.n["<leader>rI"] = { "<cmd>lua require('refactoring').refactor('Inline Function')<cr>", desc = "Inline function" }

maps.n["<leader>ri"] = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", desc = "Inline variable" }
maps.x["<leader>ri"] = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", desc = "Inline variable" }

maps.n["<leader>rr"] = { "<cmd>lua require('refactoring').select_refactor()<cr>", desc = "Select refactoring" }
maps.x["<leader>rr"] = { "<cmd>lua require('refactoring').select_refactor()<cr>", desc = "Select refactoring" }

--- Trouble
maps.n["<leader>x"] = sections.x
maps.n["<leader>xx"] = { "<cmd>lua require('trouble').open()<cr>", desc = "Toggle trouble" }
maps.n["<leader>xw"] = { "<cmd>lua require('trouble').open('workspace_diagnostics')<cr>", desc = "Workspace diagnostics" }
maps.n["<leader>xd"] = { "<cmd>lua require('trouble').open('document_diagnostics')<cr>", desc = "Document diagnostics" }
maps.n["<leader>xl"] = { "<cmd>lua require('trouble').open('loclist')<cr>", desc = "Location list" }
maps.n["<leader>xq"] = { "<cmd>lua require('trouble').open('quickfix')<cr>", desc = "Quickfix" }
maps.n["gR"] = { "<cmd>lua require('trouble').open('lsp_references')<cr>", desc = "References" }

utils.set_mappings(maps)
