# 📝 README Update Script Documentation

## Overview

The `update-readme.sh` script updates the **Cosmic Glitch Heaven README.md** with dynamic content while preserving all aesthetic, styling, and structure.

## What It Updates

### ✅ Dynamic Sections Updated:

1. **GitHub Stats URLs**
   - Updates `username=Thugger069` to use `${GH_USERNAME}` variable
   - Updates all GitHub stats API URLs

2. **Email Address**
   - Replaces `your.email@example.com` with `${EMAIL_ADDRESS}` if provided
   - Updates `mailto:` links

3. **Social Links**
   - **LinkedIn**: Updates URL if `${SECRET_LINKEDIN_URL}` is set
   - **Twitter**: Updates handle if `${SECRET_TWITTER_HANDLE}` is set

4. **Currently Working On Section**
   - Randomly selects 2-3 items from a curated list
   - Maintains glitch aesthetic with color-coded spans
   - Updates content between `<!-- DYNAMIC_CURRENT_WORK:START -->` and `<!-- DYNAMIC_CURRENT_WORK:END -->`

5. **Snake Animation Paths**
   - Updates paths from `dist/` to `output/` (GitHub Actions output)

6. **Timestamp**
   - Updates footer timestamp if present

## What It Preserves

- ✨ All Cosmic Glitch Heaven aesthetic
- 🎨 All color schemes and styling
- 📐 All HTML structure and layout
- 🖼️ All images and animations
- 📋 All static content sections
- 🎭 All glitch effects and Unicode characters

## Usage

### In GitHub Actions (Automatic)

The script runs automatically via `.github/workflows/update-readme.yml`:

```yaml
- name: Run README update script
  run: |
    chmod +x ./scripts/update-readme.sh
    ./scripts/update-readme.sh
  env:
    GH_USERNAME: ${{ github.repository_owner }}
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SECRET_EMAIL_ADDRESS: ${{ secrets.EMAIL_ADDRESS }}
    SECRET_LINKEDIN_URL: ${{ secrets.LINKEDIN_URL }}
    SECRET_TWITTER_HANDLE: ${{ secrets.TWITTER_HANDLE }}
```

### Locally (Manual)

```bash
export GH_USERNAME=Thugger069
export EMAIL_ADDRESS=your.email@example.com
export SECRET_LINKEDIN_URL=https://linkedin.com/in/yourprofile
export SECRET_TWITTER_HANDLE=yourhandle

bash scripts/update-readme.sh
```

## Required Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `GH_USERNAME` | Yes | GitHub username (defaults to `Thugger069`) |
| `GH_TOKEN` | Optional | GitHub API token for advanced features |
| `EMAIL_ADDRESS` | Optional | Email address for contact badge |
| `SECRET_LINKEDIN_URL` | Optional | LinkedIn profile URL |
| `SECRET_TWITTER_HANDLE` | Optional | Twitter/X handle |
| `SECRET_DEVTO_USERNAME` | Optional | Dev.to username (for future features) |
| `SECRET_WAKATIME_USERNAME` | Optional | WakaTime username (for future features) |

## Currently Working On Messages

The script randomly selects from these glitch-styled messages:

- Smooth Operator — Siri-triggered repl engine
- Quantum Autopilot — iOS 18 automation
- Enhancing README with dynamic content
- Building auditable AI systems
- Exploring cosmic glitch aesthetics
- Optimizing quantum workflows
- Shipping new features to shadow-scripts

Each message maintains the glitch aesthetic with:
- Color-coded spans (`#00FFFF`, `#FF00FF`, `#FFFFFF`)
- Unicode glitch characters (`%`, `_`)
- Proper HTML structure

## Output

The script provides verbose output:

```
🔄 Updating Cosmic Glitch Heaven README...
📊 Updating GitHub stats URLs...
⚡ Updating 'Currently Working On' section...
🐍 Updating snake animation paths...
🕐 Updating timestamp...
✅ README.md successfully updated with dynamic content!
   - GitHub stats: Updated for Thugger069
   - Email: Updated to your.email@example.com
   - Currently Working On: Refreshed
   - Timestamp: 2025-11-12 07:26:23 UTC
```

## Safety Features

- ✅ Creates temporary file first
- ✅ Only replaces original if successful
- ✅ Preserves all non-dynamic content
- ✅ Handles missing variables gracefully
- ✅ Exits on errors (`set -e`)

## Troubleshooting

### Issue: Dynamic content not updating
- Check that `DYNAMIC_CURRENT_WORK:START` and `DYNAMIC_CURRENT_WORK:END` markers exist
- Verify script has write permissions
- Check GitHub Actions logs

### Issue: Email/social links not updating
- Verify environment variables are set
- Check variable names match exactly
- Ensure secrets are configured in GitHub

### Issue: GitHub stats not updating
- Verify `GH_USERNAME` is set correctly
- Check GitHub API rate limits
- Verify stats URLs are accessible

## Future Enhancements

Potential additions:
- Dev.to articles integration
- WakaTime stats card
- Recent GitHub activity
- Blog posts from RSS feed
- Spotify "Now Playing" badge

---

**Last Updated**: 2025-11-12  
**Script Version**: 2.0 (Cosmic Glitch Heaven compatible)
