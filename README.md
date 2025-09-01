# Dotfiles

This repository contains my personal dotfiles for configuring my development environment.

## Prerequisites

- **macOS**: These dotfiles are primarily designed for macOS.
- **Homebrew**: Package manager for macOS. Install it from [brew.sh](https://brew.sh/).
- **Git**: Required for cloning this repository and installing Zinit.
- **Zsh**: The default shell on modern macOS versions.
- **GNU Stow**: A symlink farm manager to manage dotfiles. Install via `brew install stow`.

## Core Dependencies

These packages will be installed automatically through the setup process:

- **Zinit**: Zsh plugin manager (auto-installed if missing)
- **Powerlevel10k**: Zsh theme for a customized prompt
- **zoxide**: Smarter cd command that remembers your most used directories
- **fzf**: Command-line fuzzy finder
- **nvm**: Node Version Manager

## Installation

1. Clone this repository to your home directory:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   ```

2. Use GNU Stow to create symbolic links:
   ```bash
   cd ~/dotfiles
   stow --adopt .
   ```

   The `--adopt` flag will automatically handle any conflicts for existing files in your dotfiles repository.

3. Start a new terminal session.

## Features

- Customized Zsh prompt with Powerlevel10k
- Syntax highlighting and autosuggestions
- Fuzzy finding for files and directories
- Smart directory navigation with zoxide
- Git aliases and integrations

## Customization

Feel free to explore and modify the configuration files to suit your needs:

- `~/zsh/index.zsh`: Main configuration file
- `~/zsh/utils/`: Directory for utility functions (Sourced First)
- `~/zsh/config/`: Directory for additional configuration files (Sourced Last)
- `~/completions/`: Directory for completion files (Sourced Last)
- `~/.p10k.zsh`: Powerlevel10k theme configuration

Create private configs using naming convention: `*.private.zsh`. This won't be tracked by Git.
