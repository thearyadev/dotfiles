local M = {}
local telescope = require("telescope.builtin")

M.global_bindings = {
  { "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
  { "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

  { "n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" } },
  { "n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" } },

  { "v", "<C-/>", ":'<,'>Commentary<CR>", { noremap = true, silent = true } },
  { "n", "<C-/>", ":Commentary<CR>", { noremap = true, silent = true } },

  { "n", "<leader>i", ":Trouble diagnostics toggle<CR>", { noremap = true, silent = true } },

  { "n", "<leader>ff", ":Neoformat<CR>", { desc = "[F]ormat [F]ile", noremap = true, silent = true } },

  { "n", "<leader>?", telescope.oldfiles, { desc = "Find recently opened files" } },
  { "n", "<leader><space>", telescope.buffers, { desc = "Find Open Buffers" } },
  { "n", "<leader>ss", telescope.builtin, { desc = "[S]earch [S]elect Telescope" } },
  { "n", "<leader>gf", telescope.git_files, { desc = "Search [G]it [F]iles" } },
  { "n", "<leader>sf", telescope.find_files, { desc = "[S]earch [F]iles" } },
  { "n", "<leader>sh", telescope.help_tags, { desc = "[S]earch [H]elp" } },
  { "n", "<leader>sw", telescope.grep_string, { desc = "[S]earch current [W]ord" } },
  { "n", "<leader>sg", telescope.live_grep, { desc = "[S]earch by [G]rep" } },
  { "n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" } },
  { "n", "<leader>sr", telescope.resume, { desc = "[S]earch [R]esume" } },
}


M.lsp_bindings = {
  { "n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" } },
  { "n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" } },

  { "n", "gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" } },
  { "n", "gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" } },
  { "n", "gI", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" } },
  { "n", "<leader>D", telescope.lsp_type_definitions, { desc = "Type [D]efinition" } },

  { "n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" } },
  { "n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" } },

  { "n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" } },
  { "n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" } },

  { "n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" } },
  { "n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" } },
  { "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder" } },
}


return M
