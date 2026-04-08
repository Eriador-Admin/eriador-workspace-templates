# Agent Instructions — {{EXTENSION_NAME}}

This is a Chrome extension using Manifest V3.

## Tech Stack
- **Platform**: Chrome Extensions API
- **Manifest**: V3 (service worker, not background pages)
- **Language**: Vanilla JavaScript (no build step)

## Key Conventions
- `manifest.json` is the entry point — declares permissions, scripts, popup
- Background: service worker in `background.js` (event-driven, no persistent state)
- Content scripts in `content.js` (injected into matching pages)
- Popup UI in `popup/` (HTML + JS + CSS)
- Communication via `chrome.runtime.sendMessage()` / `chrome.runtime.onMessage`
- Storage via `chrome.storage.local` (not localStorage)

## File Patterns
- `manifest.json` → Extension declaration
- `background.js` → Service worker
- `content.js` → Content script
- `popup/*.html|js|css` → Popup interface
