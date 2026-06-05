# noine-fm Production Deployment Setup

## Overview
- App runs on Mac mini via gunicorn
- Files served from QNAP NAS mounted at `/Volumes/stern-archive`
- Exposed privately via Tailscale

---

## 1. NAS Mount Script

**File:** `~/mount-nas.sh`

```bash
#!/bin/bash
MOUNT_POINT="/Volumes/stern-archive"

if ! mount | grep -q "$MOUNT_POINT"; then
    mkdir -p "$MOUNT_POINT"
    mount_smbfs "//noinefm_appuser@10.10.10.229/stern-archive" "$MOUNT_POINT"
fi
```

Make executable:
```bash
chmod +x ~/mount-nas.sh
```

Store QNAP password in Keychain (run once):
```bash
security add-internet-password -s 10.10.10.229 -a noinefm_appuser -w
```

Manual mount command:
```bash
mount_smbfs "//noinefm_appuser@10.10.10.229/stern-archive" /Volumes/stern-archive
```

---

## 2. LaunchAgents

### fm.noine.mount.plist
**File:** `~/Library/LaunchAgents/fm.noine.mount.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>fm.noine.mount</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/sparky/mount-nas.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>300</integer>
    <key>StandardOutPath</key>
    <string>/tmp/noine-mount.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/noine-mount.err</string>
</dict>
</plist>
```

### fm.noine.plist (gunicorn)
**File:** `~/Library/LaunchAgents/fm.noine.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>fm.noine</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/sparky/projects/noine-fm/.venv/bin/gunicorn</string>
        <string>-w</string><string>2</string>
        <string>--preload</string>
        <string>-b</string><string>0.0.0.0:5050</string>
        <string>main:app</string>
    </array>
    <key>WorkingDirectory</key>
    <string>/Users/sparky/projects/noine-fm</string>
    <key>EnvironmentVariables</key>
    <dict>
        <key>MP3_DIR</key>
        <string>/Volumes/stern-archive</string>
        <key>OBJC_DISABLE_INITIALIZE_FORK_SAFETY</key>
        <string>YES</string>
    </dict>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/noine-fm.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/noine-fm.err</string>
</dict>
</plist>
```

### fm.noine.tailscale.plist
**File:** `~/Library/LaunchAgents/fm.noine.tailscale.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>fm.noine.tailscale</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/tailscale</string>
        <string>serve</string>
        <string>5050</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/noine-tailscale.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/noine-tailscale.err</string>
</dict>
</plist>
```

---

## 3. Load LaunchAgents

Run in this order:
```bash
launchctl load ~/Library/LaunchAgents/fm.noine.mount.plist
launchctl load ~/Library/LaunchAgents/fm.noine.plist
launchctl load ~/Library/LaunchAgents/fm.noine.tailscale.plist
```

---

## 4. Python / uv Setup

```bash
uv venv
uv pip install -r requirements.txt
```

---

## 5. Useful Commands

Check port in use:
```bash
lsof -i :5050
```

Kill a process by PID:
```bash
kill <PID>
```

Run app manually:
```bash
OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES uv run gunicorn -w 2 --preload -b 0.0.0.0:5050 main:app
```

Check tailscale serve status:
```bash
tailscale serve status
```

View logs:
```bash
tail -f /tmp/noine-fm.log
tail -f /tmp/noine-fm.err
tail -f /tmp/noine-mount.log
tail -f /tmp/noine-tailscale.log
```

Unload a launchd service:
```bash
launchctl unload ~/Library/LaunchAgents/fm.noine.plist
```

---

## 6. Future: Multiple Services with Caddy Reverse Proxy

As more services are added to the Mac mini, use Caddy as a reverse proxy so everything is accessible via clean URLs on port 443 instead of raw ports.

### Install Caddy
```bash
brew install caddy
```

### Caddyfile (~/ or /etc/caddy/Caddyfile)
Each service gets its own path:
```
mac-mini {
    handle /noine-fm* {
        reverse_proxy localhost:5050
    }
    handle /other-app* {
        reverse_proxy localhost:5051
    }
}
```

### Run Caddy as a launchd service
```bash
brew services start caddy
```

### Update Tailscale serve to point to Caddy (port 443) instead of individual app ports
```bash
tailscale serve 443
```

### Pattern for adding a new service
1. Deploy app on a new port (5051, 5052, etc.)
2. Create launchd plist for the app
3. Add a `handle` block in Caddyfile
4. Reload Caddy: `brew services restart caddy`
