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

### 2. Connect to Vercel
1. Go to [vercel.com](https://vercel.com)
2. Import your GitHub repo
3. **Build settings**:
   - Framework Preset: Other
   - Build Command: `flutter build web`
   - Output Directory: `build/web`
   - Install Command: (leave empty or use `flutter pub get` if needed)

4. **Important**: Add a `vercel.json` in project root:

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

5. Deploy — Vercel will build and host your Flutter web app.

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
