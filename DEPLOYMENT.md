# Deployment Guide — MUST AI Pulse

## Option 1: Firebase Hosting (Recommended)

### 1. Create Firebase project
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Create project in Firebase Console, or use existing
# Update .firebaserc with your project ID
```

### 2. Build and deploy
```bash
flutter build web
firebase deploy
```

Your app will be live at `https://YOUR_PROJECT_ID.web.app`

---

## Option 2: Vercel (Zero-config)

### 1. Push to GitHub
```bash
git init
git add .
git commit -m "Initial commit: MUST AI Pulse"
# Create repo on GitHub (maize@must.company), then:
git remote add origin https://github.com/YOUR_ORG/must-ai-pulse.git
git push -u origin main
```

### 2. Deploy via GitHub Actions (recommended)

1. **Add your Vercel token as a GitHub secret** (never commit the token):
   - GitHub repo → **Settings** → **Secrets and variables** → **Actions**
   - **New repository secret** → Name: `VERCEL_TOKEN` → Value: your Vercel token
   - (Optional) For a fixed project URL, add `VERCEL_ORG_ID` and `VERCEL_PROJECT_ID` from [Vercel Dashboard](https://vercel.com) → your project → Settings

2. Push to `main` — the workflow builds Flutter web and deploys to Vercel.

3. **Optional**: Add `vercel.json` in project root for SPA routing (already present):

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

### 2b. Connect to Vercel (manual / dashboard)

1. Go to [vercel.com](https://vercel.com)
2. Import your GitHub repo
3. **Build settings**:
   - Framework Preset: Other
   - Build Command: `flutter build web`
   - Output Directory: `build/web`
   - Install Command: (leave empty or use `flutter pub get` if needed)

4. Deploy — Vercel will build and host your Flutter web app (requires Flutter in build environment).

---

## Option 3: GitHub Pages

```bash
flutter build web --base-href "/must-ai-pulse/"
# Push build/web contents to gh-pages branch
# Or use GitHub Actions (see .github/workflows/deploy.yml)
```

---

## Local Testing

```bash
flutter run -d chrome
# Or serve built files:
cd build/web && python3 -m http.server 8000
# Open http://localhost:8000
```
