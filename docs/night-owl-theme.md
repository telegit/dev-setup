# Night Owl Theme (iTerm2 + oh-my-zsh)

Night Owl is a dark color theme by Sarah Drasner. It installs in two parts: the iTerm2 color preset (controls terminal colors) and the zsh theme (controls the prompt shape/layout).

## Step 1: iTerm2 Color Scheme

1. Download the color preset from [nickcoutsos/nightowl-iterm2](https://github.com/nickcoutsos/nightowl-iterm2) (grab the `NightOwl.itermcolors` file)
2. Import into iTerm2:
    - Open **iTerm2 → Settings → Profiles → Colors**
    - Click the **Color Presets…** dropdown → **Import…**
    - Select the downloaded `NightOwl.itermcolors` file
    - Choose **Night Owl** from the Color Presets dropdown

## Step 2: oh-my-zsh Theme

Night Owl isn't built into oh-my-zsh, so install it manually:

```bash
curl -o ~/.oh-my-zsh/themes/night-owl.zsh-theme \
  https://raw.githubusercontent.com/macguirerintoul/night-owl-iterm2-zsh-theme/main/night-owl.zsh-theme
```

Then set it in `~/.zshrc`:

```bash
ZSH_THEME="night-owl"
```

Reload your shell:

```bash
source ~/.zshrc
```

## Recommended Pairing

For the best Night Owl experience:

- **iTerm2** — Night Owl color preset (handles all colors)
- **zsh theme** — night-owl or Powerlevel10k (handles prompt layout)
- **VS Code** — Night Owl extension (search "Night Owl" by sdras)

!!! tip
    The iTerm2 color preset does the heavy lifting. The zsh theme only controls prompt shape — the actual colors come from iTerm2.

## Troubleshooting

If colors look wrong:

- Make sure **Minimum contrast** is set to `0` in iTerm2 color settings
- Check that your terminal reports 256 colors: `echo $TERM` (should show `xterm-256color`)

If the zsh theme file is missing:

```bash
ls ~/.oh-my-zsh/themes/night-owl.zsh-theme
# Re-run the curl command above if not found
```
