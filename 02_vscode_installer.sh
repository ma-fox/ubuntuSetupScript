#!/bin/bash

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

# Remove the Visual Studio Code repository
sudo rm /etc/apt/sources.list.d/vscode.list

# Update the package list again to remove the repository
sudo apt update

echo "Visual Studio Code has been installed successfully."
