# {{EXTENSION_NAME}}

A Chrome extension built with Manifest V3.

## Getting Started

```bash
bash init.sh    # no build step needed — plain JS
bash run.sh     # opens Chrome extensions page
bash stop.sh    # nothing to stop
```

## Loading the Extension

1. Open `chrome://extensions/` in Chrome
2. Enable "Developer mode" (top right)
3. Click "Load unpacked"
4. Select this project directory

## Project Structure

```
manifest.json       # Extension manifest (V3)
popup/
  popup.html        # Popup UI
  popup.js          # Popup logic
  popup.css         # Popup styles
background.js       # Service worker (background)
content.js          # Content script (injected into pages)
icons/              # Extension icons
```

## Architecture

- **Popup**: Shown when clicking the extension icon
- **Background (Service Worker)**: Runs in the background, handles events
- **Content Script**: Injected into web pages, can access DOM
