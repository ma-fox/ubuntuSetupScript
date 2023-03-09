#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu
  # Download and install the Microsoft GPG key
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  rm -f packages.microsoft.gpg

  # Add the Visual Studio Code repository to the sources list
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

  # Update the package list
  sudo apt update

  # Install Visual Studio Code
  sudo apt install -y code
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  # Install Homebrew if it's not already installed
  if ! command -v brew &> /dev/null
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install Visual Studio Code
  brew install --cask visual-studio-code
else
  echo "Unsupported operating system. This script only supports Ubuntu and MacOS."
  exit 1
fi

# Install extensions
code --install-extension ms-vscode.sublime-keybindings
code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension MS-vsliveshare.vsliveshare
code --install-extension ms-python.python
code --install-extension KevinRose.vsc-python-indent
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension github.copilot
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode

# Install Dracula Pro theme
code --install-extension themes/dracula-pro.vsix

# Set Dracula Pro theme
sed -i 's/"workbench.colorTheme": .*/"workbench.colorTheme": "Dracula Pro",/' $HOME/.config/Code/User/settings.json

echo "Visual Studio Code has been installed successfully."
