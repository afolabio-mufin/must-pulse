import '../constants/app_constants.dart';
import '../models/models.dart';

class MockData {
  static List<VgtaMetric> get vgtaMetrics => [
        VgtaMetric(
          teamName: 'Global Frontend',
          memberName: 'Team',
          value: 45000,
          gpuUsage: 2.5,
          tokenCount: 120000,
          headcount: 8,
          period: DateTime.now(),
        ),
        VgtaMetric(
          teamName: 'Korea Mobile',
          memberName: 'Team',
          value: 38000,
          gpuUsage: 2.0,
          tokenCount: 95000,
          headcount: 5,
          period: DateTime.now(),
        ),
        VgtaMetric(
          teamName: 'Global Backend',
          memberName: 'Team',
          value: 52000,
          gpuUsage: 3.0,
          tokenCount: 150000,
          headcount: 7,
          period: DateTime.now(),
        ),
      ];

  static List<AssessmentResult> get assessmentResults => [
        // Individuals – multiple members across teams
        AssessmentResult(
          userName: 'Alex Chen',
          team: 'Global Frontend',
          categoryScores: {
            'AI Code Generation': 78.0,
            'Prompt Engineering': 72.0,
            'Agent Architecture': 65.0,
            'Cursor/Copilot Mastery': 82.0,
          },
          overallScore: 74.0,
          completedAt: DateTime.now().subtract(const Duration(days: 2)),
          recommendations: [
            'Explore advanced agent patterns',
            'Share cursor rules in Prompt Vault',
          ],
        ),
        AssessmentResult(
          userName: 'Jordan Lee',
          team: 'Global Frontend',
          categoryScores: {
            'AI Code Generation': 88.0,
            'Prompt Engineering': 85.0,
            'Agent Architecture': 72.0,
            'Cursor/Copilot Mastery': 90.0,
          },
          overallScore: 84.0,
          completedAt: DateTime.now().subtract(const Duration(days: 5)),
          recommendations: ['Mentor others on agent architecture'],
        ),
        AssessmentResult(
          userName: 'Sam Rivera',
          team: 'Global Frontend',
          categoryScores: {
            'AI Code Generation': 62.0,
            'Prompt Engineering': 58.0,
            'Agent Architecture': 45.0,
            'Cursor/Copilot Mastery': 68.0,
          },
          overallScore: 58.0,
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
          recommendations: [
            'Complete Prompt Engineering module',
            'Try Debugger Agent from Agent Library',
          ],
        ),
        AssessmentResult(
          userName: 'Morgan Taylor',
          team: 'Global Backend',
          categoryScores: {
            'AI Code Generation': 92.0,
            'Prompt Engineering': 88.0,
            'Agent Architecture': 85.0,
            'Cursor/Copilot Mastery': 94.0,
          },
          overallScore: 90.0,
          completedAt: DateTime.now().subtract(const Duration(days: 3)),
          recommendations: ['Lead agent adoption in your team'],
        ),
        AssessmentResult(
          userName: 'Casey Kim',
          team: 'Global Backend',
          categoryScores: {
            'AI Code Generation': 71.0,
            'Prompt Engineering': 68.0,
            'Agent Architecture': 55.0,
            'Cursor/Copilot Mastery': 75.0,
          },
          overallScore: 67.0,
          completedAt: DateTime.now().subtract(const Duration(days: 7)),
          recommendations: ['Use QA Agent for test design'],
        ),
        AssessmentResult(
          userName: 'Riley Park',
          team: 'Korea Mobile',
          categoryScores: {
            'AI Code Generation': 80.0,
            'Prompt Engineering': 76.0,
            'Agent Architecture': 70.0,
            'Cursor/Copilot Mastery': 82.0,
          },
          overallScore: 77.0,
          completedAt: DateTime.now().subtract(const Duration(days: 4)),
          recommendations: ['Try Design Agent for UI consistency'],
        ),
        AssessmentResult(
          userName: 'Quinn Davis',
          team: 'Korea Mobile',
          categoryScores: {
            'AI Code Generation': 45.0,
            'Prompt Engineering': 42.0,
            'Agent Architecture': 38.0,
            'Cursor/Copilot Mastery': 52.0,
          },
          overallScore: 44.0,
          completedAt: DateTime.now().subtract(const Duration(days: 10)),
          recommendations: [
            'Start with Cursor basics course',
            'Use Planning Agent for task breakdown',
          ],
        ),
        AssessmentResult(
          userName: 'Devon Wright',
          team: 'DevOps',
          categoryScores: {
            'AI Code Generation': 85.0,
            'Prompt Engineering': 82.0,
            'Agent Architecture': 88.0,
            'Cursor/Copilot Mastery': 86.0,
          },
          overallScore: 85.0,
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
          recommendations: ['Contribute a runbook agent to the library'],
        ),
      ];

  static List<PromptEntry> get promptEntries => [
        PromptEntry(
          title: 'Flutter Clean Architecture Rule',
          content: '''
## Architecture
- Use Clean Architecture with BLoC
- Domain layer: pure Dart, no dependencies
- Presentation: BLoC + Equatable for state
- Repositories abstract data sources

## Cursor Rule
When generating Flutter code, always follow the project's 
feature module structure (mcs/, mdt/, mmy/, etc.)
''',
          category: 'Cursor Rules',
          author: 'Dev Team',
          team: 'Global Mobile',
          rating: 4,
          usageCount: 47,
          tags: ['flutter', 'bloc', 'clean-architecture'],
        ),
        PromptEntry(
          title: 'Debugging Agent Prompt',
          content: '''
You are an SRE debugging agent. When given an error:
1. Analyze stack trace and logs
2. Identify root cause
3. Propose fix with code changes
4. Suggest regression tests
''',
          category: 'Agent Architecture',
          author: 'DevOps',
          team: 'DevOps',
          rating: 5,
          usageCount: 23,
          tags: ['debugging', 'sre', 'agent'],
        ),
        // ——— Agent Library: Planning, Debugger, QA, Design, Code Review ———
        PromptEntry(
          title: 'Planning Agent',
          content: '''
You are a Planning Agent. Your role is to break down product and engineering goals into actionable plans.

## Responsibilities
- Turn high-level objectives into clear tasks, milestones, and dependencies
- Propose sequencing and prioritization (e.g. MVP vs later phases)
- Call out risks, assumptions, and resource needs
- Suggest acceptance criteria and success metrics

## Output format
- Structured breakdown: epics → stories/tasks with estimates
- Dependency graph or ordered backlog where relevant
- Optional: timeline or sprint suggestions

When the user gives a goal or feature request, respond with a concise plan they can execute or refine.
''',
          category: 'Planning Agent',
          author: 'Product',
          team: 'Product',
          rating: 5,
          usageCount: 34,
          tags: ['planning', 'roadmap', 'backlog', 'agent'],
        ),
        PromptEntry(
          title: 'Debugger Agent',
          content: '''
You are a Debugger Agent. Your role is to diagnose failures and propose fixes.

## Workflow
1. **Reproduce**: Confirm the failure (stack trace, logs, steps)
2. **Isolate**: Identify the failing component or code path
3. **Root cause**: Explain why it fails (logic, state, env, dependency)
4. **Fix**: Propose a minimal code or config change with rationale
5. **Verify**: Suggest how to test the fix (unit, integration, or manual)

## Guidelines
- Prefer minimal, targeted changes over large refactors
- Mention regression tests when appropriate
- If the cause is ambiguous, list hypotheses and how to confirm each

When given an error report or stack trace, respond with analysis and a concrete fix.
''',
          category: 'Debugger Agent',
          author: 'DevOps',
          team: 'DevOps',
          rating: 5,
          usageCount: 41,
          tags: ['debugging', 'sre', 'agent', 'troubleshooting'],
        ),
        PromptEntry(
          title: 'QA Agent',
          content: '''
You are a QA Agent. Your role is to ensure quality through test design and coverage analysis.

## Responsibilities
- Design test cases (happy path, edge cases, negative cases) from specs or code
- Suggest unit, integration, and E2E tests; recommend test frameworks
- Review PRs for test coverage and flakiness risks
- Propose test data and fixtures where needed

## Output format
- Test scenarios with steps, expected result, and priority
- Example test code (e.g. Jest, pytest, Flutter test) when relevant
- Checklist or acceptance criteria for manual QA if applicable

When given a feature description or code diff, respond with test plan and example tests.
''',
          category: 'QA Agent',
          author: 'QA',
          team: 'QA',
          rating: 5,
          usageCount: 28,
          tags: ['qa', 'testing', 'quality', 'agent'],
        ),
        PromptEntry(
          title: 'Design Agent',
          content: '''
You are a Design Agent. Your role is to support UI/UX and design-system consistency.

## Responsibilities
- Propose component structure, layout, and interaction patterns from requirements
- Suggest accessibility (a11y) and responsive behavior
- Align with design systems (e.g. Material, custom) and tokens (spacing, typography, color)
- Recommend copy and microcopy for buttons, errors, and empty states

## Output format
- Component hierarchy or wireframe description
- Props/API and state considerations for implementation
- Do's and don'ts for consistency and a11y

When given a feature or screen description, respond with a concise design spec or component plan.
''',
          category: 'Design Agent',
          author: 'Design',
          team: 'Product',
          rating: 5,
          usageCount: 22,
          tags: ['design', 'ui', 'ux', 'accessibility', 'agent'],
        ),
        PromptEntry(
          title: 'Code Review Agent',
          content: '''
You are a Code Review Agent. Your role is to review code for correctness, style, and maintainability.

## Checklist
- Logic and edge cases; potential bugs or performance issues
- Naming, structure, and adherence to project conventions
- Security (injection, auth, sensitive data) and error handling
- Tests: presence, quality, and coverage of changed behavior
- Docs and comments where they add value

## Output format
- Summary: overall assessment (approve / approve with comments / request changes)
- Bullet list of findings with severity (blocker / major / minor / nit) and file/line
- Concrete suggestions or patch snippets when helpful

When given a diff or PR description, respond with a structured review.
''',
          category: 'Code Review Agent',
          author: 'Dev Team',
          team: 'Global Frontend',
          rating: 5,
          usageCount: 56,
          tags: ['code-review', 'quality', 'agent', 'pr'],
        ),
        // ——— Advanced & creative prompt library ———
        PromptEntry(
          title: 'REST API Design Rule',
          content: '''
When designing or reviewing REST APIs:
- Use nouns for resources, HTTP verbs for actions (GET, POST, PUT, PATCH, DELETE)
- Version in URL path (/v1/...) or Accept header; avoid query params for versioning
- Return 201 + Location for creates; 204 for successful deletes
- Use consistent error shape: { "code", "message", "details" }
- Support filtering, sorting, pagination via query params (e.g. ?page=1&limit=20&sort=-createdAt)
- Prefer UUIDs or opaque IDs for public resource identifiers
- Document rate limits in headers (X-RateLimit-*)
''',
          category: 'Code Generation',
          author: 'Backend Team',
          team: 'Global Backend',
          rating: 5,
          usageCount: 62,
          tags: ['api', 'rest', 'design', 'backend'],
        ),
        PromptEntry(
          title: 'Security Audit Agent',
          content: '''
You are a Security Audit Agent. For the given code or design:

1. **Input validation**: SQL/NoSQL injection, XSS, command injection, path traversal
2. **Auth & authz**: Broken access control, IDOR, privilege escalation, session handling
3. **Secrets**: Hardcoded keys, env exposure, log leakage
4. **Crypto**: Weak algorithms, missing TLS, improper hashing/signing
5. **Dependencies**: Known CVEs, outdated packages

Output: prioritized list of findings with severity (critical/high/medium/low), location, and remediation. Suggest concrete fixes or config changes.
''',
          category: 'Agent Architecture',
          author: 'Security',
          team: 'DevOps',
          rating: 5,
          usageCount: 19,
          tags: ['security', 'audit', 'agent', 'compliance'],
        ),
        PromptEntry(
          title: 'Refactoring Checklist',
          content: '''
Before refactoring, confirm:
- [ ] Tests exist and are green
- [ ] Scope is bounded (single module/class or agreed boundary)
- [ ] No behavior change intended (or document intentional fixes)

During refactoring:
- Extract small steps; run tests after each
- Rename for clarity; fix duplication (DRY) and long methods
- Prefer composition over inheritance; introduce abstractions only when needed

After: run full suite, update docs, and leave a short note in the PR describing what was refactored and why.
''',
          category: 'Refactoring',
          author: 'Dev Team',
          team: 'Global Frontend',
          rating: 4,
          usageCount: 44,
          tags: ['refactoring', 'clean-code', 'checklist'],
        ),
        PromptEntry(
          title: 'Release Notes Generator',
          content: '''
Generate release notes from a list of PRs or commits. Format:

## [Version] – YYYY-MM-DD

### Added
- Feature descriptions in user-facing language (no raw commit messages)

### Changed
- Breaking or notable behavior changes with migration hints

### Fixed
- Bug fixes with issue refs if available (e.g. Fixes #123)

### Security
- Any security-related changes

Keep each line concise and audience-appropriate (product/eng). Include upgrade or migration steps when relevant.
''',
          category: 'Documentation',
          author: 'Product',
          team: 'Product',
          rating: 5,
          usageCount: 31,
          tags: ['release-notes', 'changelog', 'documentation'],
        ),
        PromptEntry(
          title: 'Incident Postmortem Template',
          content: '''
# Incident: [Short title]
**Date**: YYYY-MM-DD  
**Severity**: P1/P2/P3  
**Status**: Resolved

## Summary
1–2 sentences: what happened and user impact.

## Timeline (UTC)
- HH:MM – First detection / alert
- HH:MM – Actions taken (e.g. rollback, scale-up)
- HH:MM – Mitigation confirmed
- HH:MM – All-clear / monitoring stable

## Root cause
Technical explanation (with links to logs, dashboards, or runbooks).

## Resolution
What fixed it and any follow-up (revert, patch, config change).

## Action items
- [ ] Owner – Action (with due date)
- [ ] Prevent recurrence: monitoring, tests, docs, or process change

## Lessons learned
Brief note for the team.
''',
          category: 'Documentation',
          author: 'DevOps',
          team: 'DevOps',
          rating: 5,
          usageCount: 27,
          tags: ['incident', 'postmortem', 'sre', 'documentation'],
        ),
        PromptEntry(
          title: 'Accessibility (a11y) Review',
          content: '''
Review the provided UI/code for accessibility:

- **Semantics**: Correct heading order (h1→h2→h3), landmarks, list structure
- **Focus**: Visible focus indicators, logical tab order, no focus traps
- **Keyboard**: All actions reachable and triggerable via keyboard
- **Screen readers**: Alt text for images, aria-labels where needed, live regions for dynamic content
- **Color**: Sufficient contrast (WCAG AA); don’t rely on color alone for meaning
- **Motion**: Respect prefers-reduced-motion; avoid auto-playing motion

List issues with severity and suggested fix (code or design).
''',
          category: 'Design Agent',
          author: 'Design',
          team: 'Product',
          rating: 5,
          usageCount: 38,
          tags: ['accessibility', 'a11y', 'wcag', 'inclusive-design'],
        ),
        PromptEntry(
          title: 'Performance Review Agent',
          content: '''
You are a Performance Review Agent. For the given code, config, or architecture:

1. **Bottlenecks**: N+1 queries, large payloads, blocking I/O on hot paths
2. **Caching**: Missing or ineffective cache; TTL and invalidation strategy
3. **Frontend**: Bundle size, lazy loading, layout thrash, unnecessary re-renders
4. **Backend**: Connection pooling, timeouts, rate limiting, queue depth
5. **Observability**: Metrics, traces, and logs needed to diagnose slowness

Output: findings with impact (high/medium/low), location, and concrete recommendations (code, config, or infra).
''',
          category: 'Agent Architecture',
          author: 'DevOps',
          team: 'Global Backend',
          rating: 5,
          usageCount: 24,
          tags: ['performance', 'agent', 'optimization', 'sre'],
        ),
        PromptEntry(
          title: 'Creative Storytelling Hook',
          content: '''
Generate 3 opening hooks for a short story or article based on the theme or premise given.

Each hook should:
- Drop the reader into a specific moment (sensory or emotional)
- Raise a question or tension
- Be 1–3 sentences

Vary style: one direct and punchy, one atmospheric, one with dialogue or a bold claim. Then suggest which works best for which genre (e.g. thriller, literary, blog).
''',
          category: 'Cursor Rules',
          author: 'Content',
          team: 'Product',
          rating: 4,
          usageCount: 12,
          tags: ['creative', 'writing', 'storytelling', 'hooks'],
        ),
        PromptEntry(
          title: 'Docstring & Comment Generator',
          content: '''
From the given function or class signature (and optional code body), generate:

1. **Docstring** (language-appropriate: e.g. Dart, Python, TS):
   - One-line summary
   - Args/params with types and meaning
   - Returns and possible exceptions if relevant
   - Example usage if it clarifies (e.g. for public APIs)

2. **Inline comments** only for non-obvious logic (complex condition, workaround, or non-local dependency). Avoid stating the obvious.

Keep tone consistent with the codebase (formal vs casual). Prefer "Returns the user by ID" over "This method returns the user."
''',
          category: 'Documentation',
          author: 'Dev Team',
          team: 'Global Frontend',
          rating: 5,
          usageCount: 71,
          tags: ['documentation', 'docstring', 'comments', 'api-docs'],
        ),
        PromptEntry(
          title: 'Feature Flag Rollout Prompt',
          content: '''
When adding or changing a feature flag:

1. **Naming**: `{product}_{feature}_{behavior}` (e.g. billing_new_checkout_ui)
2. **Defaults**: Off for new features; document target % and timeline for rollout
3. **Kill switch**: Ensure the flag can disable the feature in prod without deploy
4. **Cleanup**: Add a ticket to remove flag and dead code after full rollout (e.g. 2 sprints)

In code: check flag once per request/flow; avoid branching on the same flag in many places. Log flag state in critical paths for debugging. Document in runbook how to turn off and who can do it.
''',
          category: 'DevOps',
          author: 'DevOps',
          team: 'DevOps',
          rating: 4,
          usageCount: 33,
          tags: ['feature-flag', 'rollout', 'devops', 'release'],
        ),
      ];

  /// Agent Library: dedicated AI agents (separate from Prompt Vault)
  static List<AgentLibraryEntry> get agentLibraryEntries => [
        AgentLibraryEntry(
          name: 'Planning Agent',
          slug: 'planning-agent',
          shortDescription:
              'Turns product and engineering goals into actionable plans, milestones, and backlogs.',
          fullDescription:
              'The Planning Agent breaks down high-level objectives into clear tasks, dependencies, and acceptance criteria. It proposes sequencing, calls out risks and resource needs, and can output epics, stories, and timeline suggestions.',
          category: 'Planning',
          capabilities: [
            'Goal decomposition',
            'Dependency mapping',
            'Backlog generation',
            'Risk and assumption tracking',
            'Acceptance criteria',
          ],
          integrations: ['Cursor', 'Slack', 'Jira', 'Linear'],
          author: 'Product',
          ownerTeam: 'Product',
          rating: 4.8,
          usageCount: 340,
          adoptionCount: 12,
          version: '2.1.0',
          tags: ['planning', 'roadmap', 'backlog', 'mvp'],
          promptBody: 'You are a Planning Agent. Break down goals into actionable plans.',
          examples: {
            'Feature request': 'Epic → Stories with estimates and dependencies',
            'Sprint goal': 'Ordered backlog with acceptance criteria',
          },
        ),
        AgentLibraryEntry(
          name: 'Debugger Agent',
          slug: 'debugger-agent',
          shortDescription:
              'Diagnoses failures from stack traces and logs, isolates root cause, and proposes minimal fixes.',
          fullDescription:
              'The Debugger Agent reproduces failures, isolates the failing component, explains root cause, and suggests minimal code or config changes with regression test ideas. Built for SRE and dev workflows.',
          category: 'Debugging',
          capabilities: [
            'Stack trace analysis',
            'Root cause isolation',
            'Minimal fix suggestions',
            'Regression test ideas',
            'Log correlation',
          ],
          integrations: ['Cursor', 'GitHub', 'Datadog', 'PagerDuty'],
          author: 'DevOps',
          ownerTeam: 'DevOps',
          rating: 4.9,
          usageCount: 410,
          adoptionCount: 15,
          version: '2.0.0',
          tags: ['debugging', 'sre', 'troubleshooting', 'incident'],
          promptBody: 'You are a Debugger Agent. Diagnose failures and propose fixes.',
          examples: {
            'Stack trace': 'Root cause + minimal patch + test suggestion',
            'Flaky test': 'Hypotheses and how to confirm each',
          },
        ),
        AgentLibraryEntry(
          name: 'QA Agent',
          slug: 'qa-agent',
          shortDescription:
              'Designs test cases, suggests unit/integration/E2E coverage, and reviews PRs for test quality.',
          fullDescription:
              'The QA Agent creates test scenarios from specs or code, recommends frameworks and fixtures, and reviews PRs for coverage and flakiness. Outputs test plans and example test code.',
          category: 'Quality',
          capabilities: [
            'Test scenario design',
            'Unit / integration / E2E suggestions',
            'PR test coverage review',
            'Test data and fixtures',
            'Acceptance checklists',
          ],
          integrations: ['Cursor', 'GitHub', 'Jest', 'pytest', 'Flutter test'],
          author: 'QA',
          ownerTeam: 'QA',
          rating: 4.7,
          usageCount: 280,
          adoptionCount: 10,
          version: '1.8.0',
          tags: ['qa', 'testing', 'coverage', 'quality'],
          promptBody: 'You are a QA Agent. Ensure quality through test design and coverage.',
          examples: {
            'Feature spec': 'Test scenarios + example Jest/pytest code',
            'Code diff': 'Missing edge cases and suggested tests',
          },
        ),
        AgentLibraryEntry(
          name: 'Design Agent',
          slug: 'design-agent',
          shortDescription:
              'Supports UI/UX consistency, accessibility, and design-system alignment from requirements.',
          fullDescription:
              'The Design Agent proposes component structure, layout, and interaction patterns. It suggests a11y and responsive behavior, design tokens, and copy for buttons and empty states.',
          category: 'Design',
          capabilities: [
            'Component hierarchy',
            'Accessibility (a11y)',
            'Design system alignment',
            'Responsive behavior',
            'Microcopy',
          ],
          integrations: ['Cursor', 'Figma', 'Storybook'],
          author: 'Design',
          ownerTeam: 'Product',
          rating: 4.6,
          usageCount: 220,
          adoptionCount: 8,
          version: '1.5.0',
          tags: ['design', 'ui', 'ux', 'accessibility', 'a11y'],
          promptBody: 'You are a Design Agent. Support UI/UX and design-system consistency.',
          examples: {
            'Screen description': 'Component tree + props + a11y notes',
            'New feature': 'Wireframe description + do\'s and don\'ts',
          },
        ),
        AgentLibraryEntry(
          name: 'Code Review Agent',
          slug: 'code-review-agent',
          shortDescription:
              'Reviews code for correctness, style, security, and test coverage with structured feedback.',
          fullDescription:
              'The Code Review Agent provides approve/comment/request-changes with severity-ranked findings, security and edge-case checks, and concrete patch suggestions. Integrates with PR workflows.',
          category: 'Code Review',
          capabilities: [
            'Logic and edge cases',
            'Style and conventions',
            'Security and error handling',
            'Test coverage',
            'Structured review output',
          ],
          integrations: ['Cursor', 'GitHub', 'GitLab', 'Bitbucket'],
          author: 'Dev Team',
          ownerTeam: 'Global Frontend',
          rating: 4.9,
          usageCount: 560,
          adoptionCount: 18,
          version: '2.2.0',
          tags: ['code-review', 'pr', 'quality', 'security'],
          promptBody: 'You are a Code Review Agent. Review for correctness, style, and maintainability.',
          examples: {
            'PR diff': 'Summary + findings with severity + suggestions',
            'Security review': 'Auth, injection, secrets, CVEs',
          },
        ),
        AgentLibraryEntry(
          name: 'Security Audit Agent',
          slug: 'security-audit-agent',
          shortDescription:
              'Audits code and design for vulnerabilities: injection, auth, secrets, crypto, and dependencies.',
          fullDescription:
              'The Security Audit Agent checks input validation, auth/authz, secrets handling, crypto, and dependency CVEs. Outputs prioritized findings with severity and remediation.',
          category: 'Security',
          capabilities: [
            'Input validation (injection, XSS)',
            'Auth and access control',
            'Secrets and logging',
            'Crypto and TLS',
            'Dependency CVEs',
          ],
          integrations: ['Cursor', 'GitHub', 'Snyk'],
          author: 'Security',
          ownerTeam: 'DevOps',
          rating: 4.8,
          usageCount: 190,
          adoptionCount: 7,
          version: '1.4.0',
          tags: ['security', 'audit', 'compliance', 'cve'],
          promptBody: 'You are a Security Audit Agent. Find and prioritize security issues.',
          examples: {
            'API design': 'IDOR, injection, rate limit recommendations',
            'Code snippet': 'Secrets, auth bypass, crypto issues',
          },
        ),
        AgentLibraryEntry(
          name: 'Performance Review Agent',
          slug: 'performance-review-agent',
          shortDescription:
              'Identifies bottlenecks, caching gaps, and observability needs in code and architecture.',
          fullDescription:
              'The Performance Review Agent analyzes N+1 queries, payload size, caching, frontend bundle and re-renders, backend pooling and timeouts. Outputs impact-ranked recommendations.',
          category: 'Performance',
          capabilities: [
            'Bottleneck analysis',
            'Caching strategy',
            'Frontend performance',
            'Backend tuning',
            'Observability',
          ],
          integrations: ['Cursor', 'Datadog', 'Lighthouse'],
          author: 'DevOps',
          ownerTeam: 'Global Backend',
          rating: 4.5,
          usageCount: 240,
          adoptionCount: 9,
          version: '1.3.0',
          tags: ['performance', 'optimization', 'sre'],
          promptBody: 'You are a Performance Review Agent. Find performance issues and suggest fixes.',
          examples: {
            'Service code': 'N+1, cache, timeouts',
            'Frontend bundle': 'Lazy load, re-render, layout',
          },
        ),
        AgentLibraryEntry(
          name: 'Release Notes Agent',
          slug: 'release-notes-agent',
          shortDescription:
              'Generates user-facing release notes and changelogs from PRs and commits.',
          fullDescription:
              'The Release Notes Agent turns PR/commit lists into structured Added/Changed/Fixed/Security sections with migration hints and audience-appropriate language.',
          category: 'Documentation',
          capabilities: [
            'Changelog generation',
            'Version formatting',
            'Migration steps',
            'Security section',
          ],
          integrations: ['Cursor', 'GitHub', 'Slack'],
          author: 'Product',
          ownerTeam: 'Product',
          rating: 4.7,
          usageCount: 310,
          adoptionCount: 11,
          version: '1.2.0',
          tags: ['release-notes', 'changelog', 'documentation'],
          promptBody: 'You are a Release Notes Agent. Generate release notes from PRs/commits.',
          examples: {
            'PR list': 'Added / Changed / Fixed / Security sections',
            'Breaking change': 'Migration steps and timeline',
          },
        ),
      ];
}
