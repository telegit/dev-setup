# Dotfiles Repository Setup

Machine setup and sync, backed by [`telegit/dotfiles_2026`](https://github.com/telegit/dotfiles_2026).

!!! note
    `dotfiles/` lives nested inside this repo on disk for convenience, but it's tracked as a completely separate git repository with its own remote — it's git-ignored here, not a submodule.

## New Machine Setup

On a brand new Mac, run this one command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/telegit/dotfiles_2026/main/bootstrap.sh)
```

This will:

- Install Homebrew
- Install Oh My Zsh + Powerlevel10k
- Clone the dotfiles repo
- Install all software from `Brewfile`
- Symlink dotfiles (`.zshrc`, `.gitconfig`, etc.)
- Configure Git with your name/email
- Create `~/projects` directory
- Install the `new-python-project` command
- Install VS Code extensions

## Software Included in Brewfile

| Category | Packages |
|---|---|
| Development | Git, GitHub CLI, Python (`uv`, python3.12), Node.js, Go, Lua, Love2D, VS Code, Sublime Text |
| Shell | Zsh with syntax highlighting, Powerlevel10k theme |
| Databases | PostgreSQL, MySQL, Redis |
| Containers | Docker Desktop, lazydocker |
| Utilities | wget, curl, jq, tree, htop, ripgrep (`rg`), fd, bat, eza |
| Browsers | Brave, Chrome, Firefox |
| Communication | Slack, Discord, Zoom |
| Productivity | Notion, Obsidian, Rectangle, Alfred |
| Fonts | Fira Code Nerd Font, JetBrains Mono Nerd Font, Hack Nerd Font |

## Customization

Add more software to `Brewfile`:

```bash
echo 'brew "neovim"' >> dotfiles/Brewfile
echo 'cask "spotify"' >> dotfiles/Brewfile
```

Update `Brewfile` from the current machine's installed software:

```bash
cd ~/dotfiles
brew bundle dump --force
```

Add custom aliases to `.zshrc`:

```bash
vim ~/dotfiles/.zshrc
# Add your aliases
git add .zshrc
git commit -m "Add custom aliases"
git push
```

## Sync Between Machines

Pull latest dotfiles:

```bash
cd ~/dotfiles
git pull
source ~/.zshrc
```

Push dotfiles changes:

```bash
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

## Maintenance

Keep software up to date:

```bash
brew update && brew upgrade
```

Update `Brewfile` after installing new software:

```bash
cd ~/dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
git push
```

## Troubleshooting

If symlinks break:

```bash
cd ~/dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
source ~/.zshrc
```

If the Powerlevel10k theme breaks:

```bash
p10k configure
```

If `new-python-project` isn't found:

```bash
cp ~/dotfiles/new-python-project.sh ~/.local/bin/new-python-project
chmod +x ~/.local/bin/new-python-project
```

## What Gets Synced

✓ Synced:

- ZSH configuration and aliases
- Git configuration and aliases
- Global gitignore rules
- List of all software to install (`Brewfile`)
- Python project generator script

✗ Not synced:

- VS Code settings (stored separately)
- SSH keys (never commit these!)
- API keys / credentials (use `.env` files)
- Application data
