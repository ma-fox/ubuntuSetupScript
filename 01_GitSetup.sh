#!/bin/bash

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

# Verify that the GitHub CLI has been installed
gh --version

echo "GitHub CLI has been installed successfully."
