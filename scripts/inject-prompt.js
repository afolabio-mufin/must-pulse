#!/usr/bin/env node
/**
 * Inject a prompt from Cursor (or any IDE/terminal) into the MUST AI Pulse backend.
 * Run from MUST AI Pulse repo root or scripts/ directory.
 *
 * Examples (run in Cursor terminal):
 *
 *   node scripts/inject-prompt.js --title "My Cursor Rule" --content "Always use BLoC"
 *   node scripts/inject-prompt.js --title "SRE Agent" --file .cursorrules
 *   node scripts/inject-prompt.js --title "Debug Rule" --content "..." --category "Cursor Rules" --author "Me"
 */

const fs = require('fs');
const path = require('path');
const http = require('http');

const API_BASE = process.env.MUST_PULSE_API_URL || 'http://localhost:3001';

function parseArgs() {
  const args = process.argv.slice(2);
  const out = { title: '', content: '', category: 'Cursor Rules', author: 'IDE', team: 'Unknown', tags: [] };
  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--title' && args[i + 1]) out.title = args[++i];
    else if (args[i] === '--content' && args[i + 1]) out.content = args[++i];
    else if (args[i] === '--file' && args[i + 1]) out.file = args[++i];
    else if (args[i] === '--category' && args[i + 1]) out.category = args[++i];
    else if (args[i] === '--author' && args[i + 1]) out.author = args[++i];
    else if (args[i] === '--team' && args[i + 1]) out.team = args[++i];
    else if (args[i] === '--tags' && args[i + 1]) out.tags = args[++i].split(',').map((s) => s.trim());
  }
  return out;
}

function post(url, body) {
  const u = new URL(url);
  const data = JSON.stringify(body);
  return new Promise((resolve, reject) => {
    const req = http.request(
      {
        hostname: u.hostname,
        port: u.port || 80,
        path: u.pathname,
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data),
        },
      },
      (res) => {
        let raw = '';
        res.on('data', (ch) => (raw += ch));
        res.on('end', () => {
          try {
            resolve({ status: res.statusCode, data: JSON.parse(raw || '{}') });
          } catch {
            resolve({ status: res.statusCode, data: raw });
          }
        });
      }
    );
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

async function main() {
  const opts = parseArgs();
  if (opts.file) {
    const p = path.isAbsolute(opts.file) ? opts.file : path.join(process.cwd(), opts.file);
    if (!fs.existsSync(p)) {
      console.error('File not found:', p);
      process.exit(1);
    }
    opts.content = fs.readFileSync(p, 'utf8');
  }
  if (!opts.title || !opts.content) {
    console.error('Usage: node inject-prompt.js --title "Title" (--content "..." | --file .cursorrules) [--category "Cursor Rules"] [--author "Name"]');
    process.exit(1);
  }
  try {
    const result = await post(`${API_BASE}/api/prompts`, {
      title: opts.title,
      content: opts.content,
      category: opts.category,
      author: opts.author,
      team: opts.team,
      tags: opts.tags,
    });
    if (result.status >= 200 && result.status < 300) {
      console.log('OK: Prompt injected. Id:', result.data.id);
    } else {
      console.error('API error:', result.status, result.data);
      process.exit(1);
    }
  } catch (e) {
    console.error('Request failed. Is the backend running? npm start in backend/', e.message);
    process.exit(1);
  }
}

main();
