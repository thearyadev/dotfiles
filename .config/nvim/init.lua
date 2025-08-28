require("e.lazyConfiguration")
require("e.plugins")
require("e.plugins.servers")
require("e.core")
require("e.core.autocmd")

require("e.core.apply_keymap").apply_keymaps(require("e.core.keymap").global_bindings)

vim.cmd.colorscheme("tokyonight-moon")
