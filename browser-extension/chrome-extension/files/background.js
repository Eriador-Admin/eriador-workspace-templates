// Background service worker
// Runs in the background and handles extension events

chrome.runtime.onInstalled.addListener(() => {
  console.log('{{EXTENSION_NAME}} installed');
  chrome.storage.local.set({ clickCount: 0 });
});

// Listen for messages from popup or content scripts
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.type === 'GET_COUNT') {
    chrome.storage.local.get(['clickCount'], (result) => {
      sendResponse({ count: result.clickCount || 0 });
    });
    return true; // async response
  }

  if (message.type === 'INCREMENT') {
    chrome.storage.local.get(['clickCount'], (result) => {
      const newCount = (result.clickCount || 0) + 1;
      chrome.storage.local.set({ clickCount: newCount }, () => {
        sendResponse({ count: newCount });
      });
    });
    return true;
  }
});
