#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu
  # Remove gitsome if it's installed, since it can conflict with the gh command
  sudo apt remove -y gitsome

  # Download and install the GitHub CLI keyring
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

  # Add the GitHub CLI repository to the sources list
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

  # Update the package list
  sudo apt update

  # Install the GitHub CLI
  sudo apt install -y gh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  # Install Homebrew if it's not already installed
  if ! command -v brew &> /dev/null
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install the GitHub CLI
  brew install gh
else
  echo "Unsupported operating system. This script only supports Ubuntu and MacOS."
  exit 1
fi

# Set up the git lg alias for the GitHub CLI to display a pretty log
git config --global alias.lg "log --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"

# Verify that the GitHub CLI has been installed
gh --version

echo "GitHub CLI has been installed successfully."
