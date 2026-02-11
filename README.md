# MUST AI Pulse

**AI Readiness & Productivity Intelligence Platform** for [MUST Company](https://must.company/about).

Built to support the company's initiative: *"Increase AI level to whole company member"* — a strategic response to the accelerating AI landscape where tools like Cursor, Copilot, and agent architectures are becoming table stakes.

---

## 🎯 Purpose

- **Management**: Track VGTA (Value/GPU-Token-Amount per Head) — the growth driver KPI for AI-first organizations
- **HR / Tech Personnel**: AI Skill Assessments, onboarding readiness, training gap identification
- **Developers**: Shared Prompt Vault for cursor rules, agent architectures, and effective prompts
- **Company-wide**: Gamified adoption, team analytics, ROI visibility

---

## ✨ Features

| Feature | Description |
|--------|-------------|
| **VGTA Dashboard** | CEO's formula visualized: `VGTA/H = V ÷ (G × T × H)` — value per GPU-token-amount per head |
| **AI Skill Assessment** | Interactive proficiency quiz with radar chart, skill level, and personalized recommendations |
| **Prompt Vault** | Company-wide library of cursor rules, agent configs, and prompts — rated and searchable |
| **Team Analytics** | AI adoption trends, productivity gains, token usage |
| **ROI Calculator** | Quantify time saved and cost efficiency with AI tools |

---

## 🚀 Quick Start

### Prerequisites
- Flutter 3.9+ (with web support)

### Run locally (web)
```bash
flutter pub get
flutter run -d chrome
```

### Build for production
```bash
flutter build web
```
Output: `build/web/`

### Deploy to Firebase Hosting
```bash
# Install Firebase CLI: npm install -g firebase-tools
firebase login
firebase init hosting  # Select build/web as public directory
flutter build web
firebase deploy
```

### Deploy to Vercel / Netlify
1. Connect repo to Vercel or Netlify
2. Build command: `flutter build web`
3. Output directory: `build/web`
4. Add rewrite rule: `/*` → `/index.html` (for client-side routing)

---

## 📁 Project Structure

```
lib/
├── core/           # Theme, constants, models
├── features/       # Feature modules
│   ├── landing/    # Home page
│   ├── dashboard/  # VGTA dashboard
│   ├── assessment/ # AI skill assessment
│   ├── prompt_vault/
│   ├── analytics/
│   └── calculator/ # ROI calculator
├── shared/         # Reusable widgets
└── main.dart
```

---

## 🛠 Tech Stack

- **Flutter Web** — Cross-platform, beautiful UI
- **go_router** — Client-side routing
- **fl_chart** — Charts (VGTA, radar, line)
- **Google Fonts** — Plus Jakarta Sans
- **SharedPreferences** — Local persistence (extensible to backend)

---

## 📊 Evaluation Criteria Alignment

| Criterion | How this project addresses it |
|-----------|------------------------------|
| **What was created** | Full-featured web app with 6 screens, charts, interactive calculator |
| **Amount of work** | Scalable architecture, multiple features, deployment-ready |
| **AI-generated tokens** | High — built with AI assistance (Cursor, Claude) |
| **Value & impact** | Directly supports MUST's strategic goals: VGTA metrics, AI adoption, prompt dissemination |

---

## 📄 License

Private — MUST Company internal use.

---

*Challenge · Together · Achieve* — [MUST Company](https://must.company/about)
