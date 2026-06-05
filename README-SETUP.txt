Complete Development Environment Setup
=======================================

This setup includes:
  1. Python project generator script
  2. Dotfiles repository for easy machine setup
  3. Automated installation of all your software

═══════════════════════════════════════════════════════════════
PART 1: Python Project Generator
═══════════════════════════════════════════════════════════════

INSTALLATION
------------
Copy the script to your PATH:
    cp new-python-project.sh ~/.local/bin/new-python-project
    chmod +x ~/.local/bin/new-python-project
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc

USAGE
-----
Create a general Python project:
    new-python-project my-project

Create a web application (Flask/FastAPI):
    new-python-project my-web-app --web

Create a data science project:
    new-python-project ml-analysis --data

Create a CLI application:
    new-python-project my-tool --cli

All projects include:
  - Virtual environment with uv
  - requirements.txt with relevant dependencies
  - .gitignore configured for Python
  - README.md with setup instructions
  - VS Code settings
  - Git initialized with initial commit
  - Test structure with pytest


═══════════════════════════════════════════════════════════════
PART 2: Dotfiles Repository Setup
═══════════════════════════════════════════════════════════════

INITIAL SETUP (Current Machine)
--------------------------------
1. Create a GitHub repository called "dotfiles":
   - Go to https://github.com/new
   - Name it "dotfiles"
   - Make it private
   - Don't initialize with README

2. Initialize your dotfiles:
   cd ~/Desktop/dev-setup/dotfiles
   git init
   git add .
   git commit -m "Initial dotfiles setup"
   git branch -M main
   git remote add origin git@github.com:YOUR_USERNAME/dotfiles.git
   git push -u origin main

3. Update your .gitconfig with your info:
   - Edit dotfiles/.gitconfig
   - Replace YOUR_NAME and YOUR_EMAIL
   - Commit and push changes

4. Copy new-python-project.sh to dotfiles:
   cp ../new-python-project.sh dotfiles/
   git add new-python-project.sh
   git commit -m "Add Python project generator"
   git push


NEW MACHINE SETUP (Future Machines)
------------------------------------
On a brand new Mac, run this ONE command:

    bash <(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/bootstrap.sh)

This will:
  ✓ Install Homebrew
  ✓ Install Oh My Zsh + Powerlevel10k
  ✓ Clone your dotfiles repo
  ✓ Install ALL software from Brewfile
  ✓ Symlink dotfiles (.zshrc, .gitconfig, etc.)
  ✓ Configure Git with your name/email
  ✓ Create ~/projects directory
  ✓ Install new-python-project command
  ✓ Install VS Code extensions

NOTE: You'll need to upload bootstrap.sh to your GitHub repo first!


SOFTWARE INCLUDED IN BREWFILE
------------------------------
Development:
  - Git, GitHub CLI
  - Python (uv, python3.12)
  - Node.js, Go, Lua, Love2D
  - VS Code, Sublime Text

Shell:
  - Zsh with syntax highlighting
  - Powerlevel10k theme

Databases:
  - PostgreSQL, MySQL, Redis, MongoDB

Containers:
  - Docker Desktop
  - lazydocker (terminal UI)

Utilities:
  - wget, curl, jq, tree, htop
  - ripgrep (rg), fd, bat, eza

Browsers:
  - Brave Browser, Chrome, Firefox

Communication:
  - Slack, Discord, Zoom

Productivity:
  - Notion, Obsidian, Rectangle, Alfred

Fonts:
  - Fira Code Nerd Font
  - JetBrains Mono Nerd Font
  - Hack Nerd Font


CUSTOMIZATION
-------------
Add more software to Brewfile:
    echo 'brew "neovim"' >> dotfiles/Brewfile
    echo 'cask "spotify"' >> dotfiles/Brewfile

Update Brewfile from current machine:
    cd ~/dotfiles
    brew bundle dump --force

Add custom aliases to .zshrc:
    vim ~/dotfiles/.zshrc
    # Add your aliases
    git add .zshrc
    git commit -m "Add custom aliases"
    git push


SYNC BETWEEN MACHINES
----------------------
Pull latest dotfiles:
    cd ~/dotfiles
    git pull
    source ~/.zshrc

Push dotfiles changes:
    cd ~/dotfiles
    git add .
    git commit -m "Update configuration"
    git push


MAINTENANCE
-----------
Keep software up to date:
    brew update && brew upgrade

Update Brewfile after installing new software:
    cd ~/dotfiles
    brew bundle dump --force
    git add Brewfile
    git commit -m "Update Brewfile"
    git push


TROUBLESHOOTING
---------------
If symlinks break:
    cd ~/dotfiles
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
    source ~/.zshrc

If Powerlevel10k theme breaks:
    p10k configure

If new-python-project not found:
    cp ~/dotfiles/new-python-project.sh ~/.local/bin/new-python-project
    chmod +x ~/.local/bin/new-python-project


WHAT GETS SYNCED
----------------
✓ ZSH configuration and aliases
✓ Git configuration and aliases
✓ Global gitignore rules
✓ List of all software to install
✓ Python project generator script

✗ VS Code settings (stored separately)
✗ SSH keys (never commit these!)
✗ API keys / credentials (use .env files)
✗ Application data


═══════════════════════════════════════════════════════════════
PART 4: Night Owl Theme (iTerm2 + oh-my-zsh)
═══════════════════════════════════════════════════════════════

Night Owl is a dark color theme by Sarah Drasner. Install it in
two parts: the iTerm2 color preset (controls terminal colors) and
the zsh theme (controls the prompt shape/layout).


STEP 1: iTerm2 Color Scheme
----------------------------
1. Download the color preset:
   https://github.com/nickcoutsos/nightowl-iterm2
   (grab the NightOwl.itermcolors file)

2. Import into iTerm2:
   - Open iTerm2 → Settings → Profiles → Colors
   - Click "Color Presets..." dropdown → "Import..."
   - Select the downloaded NightOwl.itermcolors file
   - Choose "Night Owl" from the Color Presets dropdown


STEP 2: oh-my-zsh Theme
------------------------
Night Owl is not built into oh-my-zsh, so install it manually:

   curl -o ~/.oh-my-zsh/themes/night-owl.zsh-theme \
     https://raw.githubusercontent.com/macguirerintoul/night-owl-iterm2-zsh-theme/main/night-owl.zsh-theme

Then set it in ~/.zshrc:
   ZSH_THEME="night-owl"

Reload your shell:
   source ~/.zshrc


RECOMMENDED PAIRING
--------------------
For the best Night Owl experience:
  - iTerm2       → Night Owl color preset (handles all colors)
  - zsh theme    → night-owl or Powerlevel10k (handles prompt layout)
  - VS Code      → Night Owl extension (search "Night Owl" by sdras)

NOTE: The iTerm2 color preset does the heavy lifting. The zsh theme
only controls prompt shape — the actual colors come from iTerm2.


TROUBLESHOOTING
---------------
If colors look wrong:
  - Make sure "Minimum contrast" is set to 0 in iTerm2 color settings
  - Check that your terminal reports 256 colors: echo $TERM
    (should show xterm-256color)

If the zsh theme file is missing:
  ls ~/.oh-my-zsh/themes/night-owl.zsh-theme
  # Re-run the curl command above if not found
