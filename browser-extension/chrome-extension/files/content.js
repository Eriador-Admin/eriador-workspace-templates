// Content script — injected into web pages
// Has access to the page DOM but runs in an isolated world

console.log('{{EXTENSION_NAME}} content script loaded');

// Example: listen for messages from the popup or background
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.type === 'GET_PAGE_TITLE') {
    sendResponse({ title: document.title });
  }
});
