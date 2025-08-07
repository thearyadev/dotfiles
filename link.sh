
# zsh
ln ./zsh/.zshrc ~/.zshrc
ln ./zsh/.p10k.zsh ~/.p10k.zsh

# nvim
mkdir -p ~/.config/nvim/lua/{binds,plugins,theme}
ln ./nvim/init.lua ~/.config/nvim/init.lua
ln ./nvim/lua/binds/init.lua ~/.config/nvim/lua/binds/init.lua
ln ./nvim/lua/plugins/init.lua ~/.config/nvim/lua/plugins/init.lua
ln ./nvim/lua/theme/init.lua ~/.config/nvim/lua/theme/init.lua

# tmux
ln ./tmux/.tmux.conf ~/.tmux.conf

# ghostty
mkdir -p ~/.config/ghostty
ln ./ghostty/* ~/.config/ghostty/

# hyprland
mkdir -p ~/.config/hypr/
ln ./hypr/* ~/.config/hypr/

