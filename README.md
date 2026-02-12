MUST Pulse – Readiness & Productivity Intelligence Platform
Developer: Odurinde Afolabi 
Repository: https://github.com/afolabio-mufin/must-pulse.git 
Live app: https://must-pulse-n35mjfoj0-odurindeafolabis-projects.vercel.app/ 

Project overview
Objective
Support MUST Company’s initiative to raise overall digital readiness by building a single platform where management, HR, and developers can measure tool adoption, share best practices, and track productivity impact.
Problem addressed
Teams lack a shared view of how new tools are used and how much value they deliver.
There is no company‑wide place to store and reuse workflows, rules, and templates.
Management has no simple KPI to track value delivered per team.
Technical staff spend time reinventing solutions instead of reusing what already works.
Solution
 MUST Pulse is a Flutter web app that brings together a dashboard, skill assessment, workflow vault & template library, team analytics, and an ROI calculator in one place — so the organisation can see where it stands today and where to improve.

Implementation
1. Key features
Landing & navigation
 Clear entry point with feature cards (Dashboard, Assessment, Vault, Library, Analytics, ROI Calculator). Responsive layout.
Dashboard
 Visualises value metrics per team. KPI cards and comparison charts help leadership see which groups are getting the most out of digital tools.
Skill assessment
 Interactive view with overall score, radar chart by category (e.g. code generation, workflow design, automation), and personalized recommendations so individuals and HR can identify gaps.
Workflow Vault & Template Library
 Central library of rules and templates. Includes predefined agents: Planning, Debugger, QA, Design, and Code Review. Each entry can be opened to view details, copy, import, request access, and collaborate. Analysis (word count, estimated tokens, tags) helps teams choose and tune workflows.
Team analytics
 High‑level view of adoption and trends (mock data today; ready to connect to a backend).
ROI calculator
 Sliders for hours without vs with tools, hourly rate, etc. Shows time saved, efficiency gain, and cost saved so teams can quantify benefits.
2. Approach
Flutter web for one codebase, fast iteration, and easy deployment (e.g. Vercel).
Feature‑based structure for clarity and future scaling.
Mock data first so the app is usable without a backend; design is ready to swap to APIs when the organisation is ready.
Optional backend + injector so workflows can be pushed from IDEs into a small API and the web app can display them — documented in DATA_INJECTION.md.
3. Tech used
Flutter 3.x (web), go_router, fl_chart.
Built with assisted development tools.

Value and impact
For the organisation
One place to see adoption and the value it generates.
Shared library reduces duplication and speeds onboarding.
Clear metrics and ROI visibility to support investment and strategy.
For MUST Company
Directly supports the goal to raise readiness across the whole company.
Aligns with leadership’s framing and the culture of “Challenge · Together · Achieve.”
Demonstrates a practical, deployable product that can be extended with real data and permissions.
For tech staff
Reuse proven templates instead of starting from scratch.
One‑click copy and import into the daily workflow.
Skill assessment and recommendations to focus learning.
ROI calculator to articulate value to stakeholders.

Work completed
Full Flutter web app: landing, dashboard, skill assessment, Vault, Library (Planning, Debugger, QA, Design, Code Review), team analytics, ROI calculator.
Detail flow: view full content, copy, import, request access, collaborate section, analysis (words, tokens, tags).
17+ examples (rules, agents, API design, security, refactoring, docs, accessibility, performance, feature flags, etc.).
Optional Node backend and injector script so data can be sent from IDE and fetched by the app.
Themed UI, responsive layout, and deployment to Vercel.
Documentation: README, SUBMISSION.md, DEPLOYMENT.md, DATA_INJECTION.md, and this submission.

Future plans & roadmap
Backend & auth
 Replace mock data with a real API; add authentication and team‑based access so data is scoped per org/team.
Vault
 Search and filter by category/tag; versioning and “fork”; real collaboration (comments, edit access, approval flow).
Dashboard & analytics
 Ingest real usage metrics; more charts and time ranges; export for leadership.
Integrations
 Deeper import into IDEs; optional integrations with Slack or Notion for sharing.
Gamification & learning
 Badges or progress tied to assessment and usage; suggested learning paths based on results.

How to run
git clone https://github.com/afolabio-mufin/must-pulse.git 
cd must-ai-pulse
flutter pub get
flutter run -d chrome
Or open the live app: https://must-pulse-n35mjfoj0-odurindeafolabis-projects.vercel.app/ 

