local M = {}
function M.apply_keymaps(bindings)
  for _, map in ipairs(bindings) do
    vim.keymap.set(map[1], map[2], map[3], map[4])
  end
end

return M
