#!/bin/bash
# Machine Setup Bootstrap Script
# This script sets up a new Mac from scratch with all your dev tools and dotfiles

set -e

echo "========================================="
echo "  Mac Development Environment Setup"
echo "========================================="
echo ""

# ─── Check for Homebrew ──────────────────────────────────────
if ! command -v brew &> /dev/null; then
    echo "=== Installing Homebrew ==="
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✓ Homebrew already installed"
fi

# ─── Update Homebrew ─────────────────────────────────────────
echo ""
echo "=== Updating Homebrew ==="
brew update

# ─── Install Oh My Zsh ───────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ""
    echo "=== Installing Oh My Zsh ==="
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✓ Oh My Zsh already installed"
fi

# ─── Clone dotfiles repo ─────────────────────────────────────
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo ""
    echo "=== Cloning dotfiles repository ==="
    read -p "Enter your dotfiles GitHub repo URL (or press Enter to skip): " REPO_URL

    if [ ! -z "$REPO_URL" ]; then
        git clone "$REPO_URL" "$DOTFILES_DIR"
    else
        echo "Skipping dotfiles clone. You'll need to set this up manually."
        mkdir -p "$DOTFILES_DIR"
    fi
else
    echo "✓ Dotfiles directory already exists"
fi

# ─── Install software with Brewfile ──────────────────────────
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo ""
    echo "=== Installing software from Brewfile ==="
    brew bundle --file="$DOTFILES_DIR/Brewfile"
else
    echo "! Brewfile not found. Skipping software installation."
fi

# ─── Symlink dotfiles ────────────────────────────────────────
echo ""
echo "=== Setting up dotfiles ==="

# Backup existing files
backup_and_link() {
    source_file="$1"
    target_file="$2"

    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "  Backing up existing $target_file to ${target_file}.backup"
        mv "$target_file" "${target_file}.backup"
    fi

    if [ -f "$source_file" ]; then
        ln -sf "$source_file" "$target_file"
        echo "  ✓ Linked $target_file"
    fi
}

backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# ─── Configure Git ───────────────────────────────────────────
echo ""
echo "=== Git Configuration ==="
read -p "Enter your Git name: " git_name
read -p "Enter your Git email: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.excludesfile "$HOME/.gitignore_global"

# ─── Install Powerlevel10k ───────────────────────────────────
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo ""
    echo "=== Installing Powerlevel10k theme ==="
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "✓ Powerlevel10k already installed"
fi

# ─── Create directories ──────────────────────────────────────
echo ""
echo "=== Creating project directories ==="
mkdir -p ~/projects
mkdir -p ~/Documents/workspace

# ─── Install Python tools ────────────────────────────────────
echo ""
echo "=== Setting up Python environment ==="
if command -v uv &> /dev/null; then
    # Install global Python tools
    pip3 install --upgrade pip
    echo "✓ Python tools ready"
fi

# ─── Setup helper scripts ────────────────────────────────────
echo ""
echo "=== Installing helper scripts ==="

# Add new-python-project to PATH
SCRIPT_DIR="$HOME/.local/bin"
mkdir -p "$SCRIPT_DIR"

if [ -f "$DOTFILES_DIR/new-python-project.sh" ]; then
    cp "$DOTFILES_DIR/new-python-project.sh" "$SCRIPT_DIR/new-python-project"
    chmod +x "$SCRIPT_DIR/new-python-project"
    echo "✓ new-python-project installed"
fi

# Add to PATH if not already there
if [[ ":$PATH:" != *":$SCRIPT_DIR:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# ─── VS Code extensions ──────────────────────────────────────
if command -v code &> /dev/null; then
    echo ""
    echo "=== Installing VS Code extensions ==="
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension sumneko.lua
    code --install-extension ms-azuretools.vscode-docker
    echo "✓ VS Code extensions installed"
fi

# ─── Final steps ─────────────────────────────────────────────
echo ""
echo "========================================="
echo "  Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Docker Desktop from Applications"
echo "  3. Configure your Git SSH keys: https://docs.github.com/en/authentication"
echo "  4. Customize your dotfiles in ~/dotfiles/"
echo ""
echo "Useful commands:"
echo "  new-python-project <name>    Create new Python project"
echo "  brew bundle dump              Update your Brewfile"
echo "  cd ~/projects                 Go to projects directory"
echo ""
