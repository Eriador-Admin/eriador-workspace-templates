document.addEventListener('DOMContentLoaded', () => {
  const countEl = document.getElementById('count');
  const incrementBtn = document.getElementById('increment');
  const pageTitleEl = document.getElementById('page-title');

  // Get current count
  chrome.runtime.sendMessage({ type: 'GET_COUNT' }, (response) => {
    if (response) countEl.textContent = response.count;
  });

  // Increment count
  incrementBtn.addEventListener('click', () => {
    chrome.runtime.sendMessage({ type: 'INCREMENT' }, (response) => {
      if (response) countEl.textContent = response.count;
    });
  });

  // Get current tab's title
  chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
    if (tabs[0]) {
      chrome.tabs.sendMessage(tabs[0].id, { type: 'GET_PAGE_TITLE' }, (response) => {
        if (response) {
          pageTitleEl.textContent = `Page: ${response.title}`;
        }
      });
    }
  });
});
