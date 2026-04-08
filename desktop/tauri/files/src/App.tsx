import { useState } from 'react';
import { invoke } from '@tauri-apps/api/tauri';

export default function App() {
  const [greeting, setGreeting] = useState('');
  const [name, setName] = useState('');

  async function greet() {
    const result = await invoke<string>('greet', { name });
    setGreeting(result);
  }

  return (
    <div style={{ fontFamily: 'system-ui', padding: 40, textAlign: 'center' }}>
      <h1>{{WINDOW_TITLE}}</h1>
      <p>Built with Tauri + React + Rust</p>
      <div>
        <input
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Enter a name..."
        />
        <button onClick={greet}>Greet</button>
      </div>
      {greeting && <p>{greeting}</p>}
    </div>
  );
}
