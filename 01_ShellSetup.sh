#!/bin/bash

#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu
  sudo apt install -y curl zsh git
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  brew install curl zsh git
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Install zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Replace contents of .zshrc file
cat > ~/.zshrc <<EOF
ZSH="/home/harshith/.oh-my-zsh"

#Theme
ZSH_THEME=""

#Plugins
plugins=(git zsh-autosuggestions)
source \$ZSH/oh-my-zsh.sh

#Star Ship
eval "\$(starship init zsh)"
EOF

# Set Zsh as the default shell
sudo chsh -s $(which zsh) $USER

# Source the .zshrc file
source ~/.zshrc

# For Ubuntu:
# You must have sudo privileges to install packages using apt.

# For MacOS:
# You must have Homebrew installed to install packages using brew.
# You must have Xcode Command Line Tools installed, which can be installed by running xcode-select --install in the terminal.

# Additionally, if you want to use the zsh-autosuggestions plugin, you need to have Git installed.

# Finally, note that this script assumes that you want to set Zsh as the default shell for the current user.
# If you want to set Zsh as the default shell for a different user, you will need to modify the chsh command accordingly.
