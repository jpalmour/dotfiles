# 1Password CLI Setup Guide

This guide explains how to set up the required 1Password items for this dotfiles repository to work correctly.

## Prerequisites

1. 1Password desktop app installed and signed in
2. 1Password CLI (`op`) installed and integrated with the desktop app
3. SSH Agent enabled in 1Password settings

## Required 1Password Items

### 1. SSH Key - "Dev SSH Key"

The templates expect an SSH key item named exactly **"Dev SSH Key"** with a field named **"Public Key"**.

#### Create the SSH Key via CLI:

```bash
# Generate a new SSH key and add it to 1Password
op item create \
  --category "SSH Key" \
  --title "Dev SSH Key" \
  --ssh-generate-key ed25519
```

**Alternative: If you have an existing SSH key:**

```bash
# Import existing SSH key to 1Password
# First, ensure your key files exist at ~/.ssh/id_ed25519 and ~/.ssh/id_ed25519.pub
op item create \
  --category "SSH Key" \
  --title "Dev SSH Key" \
  --ssh-key-file="$HOME/.ssh/id_ed25519"
```

#### Get the Public Key for GitHub:

```bash
# Display the public key to add to GitHub
op item get "Dev SSH Key" --fields "public key"

# Or copy directly to clipboard (macOS)
op item get "Dev SSH Key" --fields "public key" | pbcopy

# Or copy directly to clipboard (Linux with xclip)
op item get "Dev SSH Key" --fields "public key" | xclip -selection clipboard

# Or copy directly to clipboard (Windows PowerShell)
op item get "Dev SSH Key" --fields "public key" | Set-Clipboard
```

#### Add to GitHub:

1. Go to https://github.com/settings/keys
2. Click "New SSH key"
3. Set Title: "Dev SSH Key (1Password)"
4. Set Key type: "Authentication Key"
5. Paste the public key
6. Click "Add SSH key"
7. Repeat steps 2-6 but select "Signing Key" as the Key type

### 2. SSH Hosts Configuration - "ssh-hosts"

The templates expect an item named **"ssh-hosts"** with a field named **"hosts"** containing SSH config entries.

#### Create the SSH Hosts Item:

```bash
# Create a secure note with SSH host configurations
op item create \
  --category "Secure Note" \
  --title "ssh-hosts" \
  "hosts=Host myserver
    HostName 192.168.1.100
    User myuser
    Port 22

Host github.com
    HostName github.com
    User git
    
Host gitlab.com
    HostName gitlab.com
    User git"
```

**To update existing hosts configuration:**

```bash
# First, view current hosts (if it exists)
op item get "ssh-hosts" --fields "hosts"

# Edit the item (this will open in your default editor)
op item edit "ssh-hosts"
```

**Example hosts content structure:**
```
Host personal-server
    HostName personal.example.com
    User john
    Port 2222
    
Host work-dev
    HostName dev.company.com
    User jdoe
    ForwardAgent yes
    
Host bastion
    HostName bastion.company.com
    User admin
    Port 22
    
Host internal-* 
    ProxyJump bastion
    User admin
```

## Verify Setup

After creating both items, verify they're accessible:

```bash
# Test that both items exist and have the required fields
echo "Testing Dev SSH Key..."
op item get "Dev SSH Key" --fields "public key" > /dev/null && echo "✅ SSH Key found" || echo "❌ SSH Key missing or incorrect"

echo "Testing ssh-hosts..."
op item get "ssh-hosts" --fields "hosts" > /dev/null && echo "✅ SSH hosts found" || echo "❌ SSH hosts missing or incorrect"
```

## Complete Setup Flow

1. **First run** - Initial template generation (will skip 1Password content):
   ```bash
   chezmoi apply
   ```

2. **1Password Setup** - The script will:
   - Install 1Password desktop and CLI
   - Open 1Password app
   - Prompt you to enable CLI integration AND SSH agent

3. **Create 1Password items** - Follow the commands above to create:
   - "Dev SSH Key" item
   - "ssh-hosts" item

4. **Add SSH key to GitHub** for both authentication and signing

5. **Final apply** - Generate complete configuration:
   ```bash
   chezmoi apply
   ```

## Troubleshooting

### "Could not read 'public key' field from 1Password SSH Key item"

This means the "Dev SSH Key" item exists but doesn't have a "Public Key" field. For SSH Key items created properly, this field should be automatic. Verify the item type is "SSH Key" not "Secure Note".

### "No 'hosts' field found on 1Password item 'ssh-hosts'"

The "ssh-hosts" item exists but doesn't have a field named "hosts". Edit the item and add a field with that exact name.

### SSH Agent not working

Ensure you've enabled the SSH agent in 1Password:
- Open 1Password → Settings → Developer
- Enable "Use the SSH agent"
- Enable "Authorize connections" (recommended)
- Add your SSH keys to the agent

### Testing SSH with 1Password Agent

```bash
# Verify the agent is working
ssh-add -l

# Test GitHub connection
ssh -T git@github.com
```

## SSH Key Rotation

This setup makes SSH key rotation simple and automated:

### Rotate Your SSH Key:

1. **Rename the existing key in 1Password**:
   ```bash
   # This will make chezmoi unable to find the key
   op item edit "Dev SSH Key" title="Dev SSH Key - Old ($(date +%Y-%m))"
   ```

2. **Run chezmoi apply**:
   ```bash
   chezmoi apply
   ```
   The system will detect the missing key and prompt you to create a new one.

3. **Create new key interactively**:
   - Answer "y" when prompted to create a new SSH key
   - The script automatically:
     - Generates a new Ed25519 key
     - Adds creation date metadata
     - Displays the public key for GitHub
     - Reminds you to add it to GitHub twice (auth + signing)

4. **Update GitHub**:
   - Remove the old key from GitHub
   - Add the new key for both authentication and signing

### Check Key Age:

When you run the 1Password setup script, it will show you when your current key was created:
```
[linux] ✅ SSH key 'Dev SSH Key' found in 1Password.
[linux]    Created: 2024-01-15 10:30:45 UTC
```

### Manual Key Rotation:

If you prefer to rotate manually:

```bash
# Create new key with timestamp
op item create --category "SSH Key" --title "Dev SSH Key" --ssh-generate-key ed25519 \
  "Creation Date[text]=$(date -u +'%Y-%m-%d %H:%M:%S UTC')" \
  "Purpose[text]=Development machine SSH authentication and Git signing"

# Get the public key
op item get "Dev SSH Key" --fields "public key"

# Add to GitHub twice (auth + signing)
# Then run chezmoi apply to update configurations
```

### Get More Verbose CLI Logs

If key creation fails with unhelpful output, increase verbosity and run the command directly:

```bash
# Enable verbose logging
export OP_LOG_LEVEL=debug   # or run with DEBUG=1 where supported

# Re-run the key creation to capture detailed errors
op item create \
  --category "SSH Key" \
  --title "Dev SSH Key" \
  --ssh-generate-key ed25519
```

Common causes of failures:
- 1Password app is locked or CLI not integrated (check: `op account list`)
- SSH Agent not enabled in 1Password Settings → Developer
- Insufficient account permissions to create SSH Key items
- Using an older CLI (update and verify with `op --version`)

## Security Notes

- The "Dev SSH Key" private key never leaves 1Password
- The public key is safe to share and is what gets added to GitHub
- The "ssh-hosts" item should only contain host configurations, never passwords or private keys
- 1Password's SSH agent handles authentication without exposing keys to the filesystem
- Key rotation is safe and automated - old keys can be kept for reference
