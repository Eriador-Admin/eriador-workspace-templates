import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root'));
const useStrictMode = '{{USE_STRICT_MODE}}' !== 'false';

root.render(
  useStrictMode
    ? <React.StrictMode><App /></React.StrictMode>
    : <App />
);
