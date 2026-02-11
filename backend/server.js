/**
 * Example backend for MUST AI Pulse.
 * - POST /api/prompts — receive prompt data from Cursor/IDE (injector script)
 * - GET  /api/prompts — serve prompts to the web app
 *
 * Run: npm install && npm start
 * Default: http://localhost:3001
 */

const fs = require('fs');
const path = require('path');
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;
const DATA_DIR = path.join(__dirname, 'data');
const PROMPTS_FILE = path.join(DATA_DIR, 'prompts.json');

app.use(cors({ origin: true })); // Allow Flutter web (any origin in dev)
app.use(express.json());

function ensureDataDir() {
  if (!fs.existsSync(DATA_DIR)) fs.mkdirSync(DATA_DIR, { recursive: true });
}

function readPrompts() {
  ensureDataDir();
  if (!fs.existsSync(PROMPTS_FILE)) return [];
  try {
    const raw = fs.readFileSync(PROMPTS_FILE, 'utf8');
    return JSON.parse(raw);
  } catch {
    return [];
  }
}

function writePrompts(prompts) {
  ensureDataDir();
  fs.writeFileSync(PROMPTS_FILE, JSON.stringify(prompts, null, 2), 'utf8');
}

// ——— GET: web app fetches prompts ———
app.get('/api/prompts', (req, res) => {
  const prompts = readPrompts();
  res.json(prompts);
});

// ——— POST: Cursor/IDE injector sends a new prompt ———
app.post('/api/prompts', (req, res) => {
  const { title, content, category, author, team, rating, usageCount, tags } = req.body || {};
  if (!title || !content) {
    return res.status(400).json({ error: 'title and content are required' });
  }
  const prompts = readPrompts();
  const id = `prompt-${Date.now()}-${Math.random().toString(36).slice(2, 9)}`;
  const entry = {
    id,
    title: String(title),
    content: String(content),
    category: String(category || 'Cursor Rules'),
    author: String(author || 'IDE'),
    team: String(team || 'Unknown'),
    rating: Number(rating) || 0,
    usageCount: Number(usageCount) || 0,
    createdAt: new Date().toISOString(),
    tags: Array.isArray(tags) ? tags : (tags ? [String(tags)] : []),
  };
  prompts.push(entry);
  writePrompts(prompts);
  res.status(201).json(entry);
});

// Health check
app.get('/health', (req, res) => res.json({ ok: true }));

app.listen(PORT, () => {
  console.log(`MUST AI Pulse API at http://localhost:${PORT}`);
  console.log('  GET  /api/prompts  — list prompts (for web app)');
  console.log('  POST /api/prompts  — add prompt (from Cursor/IDE script)');
});
