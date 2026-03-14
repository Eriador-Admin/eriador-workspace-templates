import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';

function Home() {
  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold">Welcome</h1>
      <p className="mt-2 text-gray-600">Your React + Vite app is ready.</p>
    </div>
  );
}

function About() {
  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold">About</h1>
      <p className="mt-2 text-gray-600">Built with React, Vite, and Tailwind CSS.</p>
    </div>
  );
}

export default function App() {
  return (
    <BrowserRouter>
      <nav className="flex gap-4 p-4 bg-gray-100">
        <Link to="/" className="text-blue-600 hover:underline">Home</Link>
        <Link to="/about" className="text-blue-600 hover:underline">About</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </BrowserRouter>
  );
}
