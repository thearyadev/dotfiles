local servers = {
	pyright = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	gopls = {},
	clangd = {},
	rust_analyzer = {},
 	csharp_ls = {}
}

local lspconfig = require("lspconfig")
local bindings = require("e.core.keymap")
local apply_keymaps = require("e.core.apply_keymap")

local function on_attach(_, bufnr)
	local bind_bufnum_attached = {}
	for _, m in ipairs(bindings.lsp_bindings) do
		-- ensures that each lsp binding has a buffernumber attached to it.
		local mode, lhs, rhs, opts = m[1], m[2], m[3], m[4] or {}
		opts.buffer = bufnr
		table.insert(bind_bufnum_attached, { mode, lhs, rhs, opts })
	end

	apply_keymaps.apply_keymaps(bind_bufnum_attached)
end

for server, config in pairs(servers) do
	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
	config.on_attach = on_attach
	lspconfig[server].setup(config)
end
