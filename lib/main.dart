import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'core/models/models.dart';
import 'core/theme/app_theme.dart';
import 'features/agent_library/agent_library_detail_page.dart';
import 'features/agent_library/agent_library_page.dart';
import 'features/analytics/analytics_page.dart';
import 'features/assessment/assessment_page.dart';
import 'features/calculator/calculator_page.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/landing/landing_page.dart';
import 'features/prompt_vault/prompt_detail_page.dart';
import 'features/prompt_vault/prompt_vault_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MustAiPulseApp());
}

class MustAiPulseApp extends StatelessWidget {
  const MustAiPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MUST AI Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const LandingPage()),
    GoRoute(path: '/dashboard', builder: (_, __) => const DashboardPage()),
    GoRoute(path: '/assessment', builder: (_, __) => const AssessmentPage()),
    GoRoute(path: '/prompts', builder: (_, __) => const PromptVaultPage()),
    GoRoute(
      path: '/prompts/detail',
      builder: (_, state) {
        final prompt = state.extra is PromptEntry
            ? state.extra! as PromptEntry
            : null;
        if (prompt == null) return const PromptVaultPage();
        return PromptDetailPage(prompt: prompt);
      },
    ),
    GoRoute(
      path: '/agent-library',
      builder: (_, __) => const AgentLibraryPage(),
    ),
    GoRoute(
      path: '/agent-library/detail',
      builder: (_, state) {
        final agent = state.extra is AgentLibraryEntry
            ? state.extra! as AgentLibraryEntry
            : null;
        if (agent == null) return const AgentLibraryPage();
        return AgentLibraryDetailPage(agent: agent);
      },
    ),
    GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsPage()),
    GoRoute(path: '/calculator', builder: (_, __) => const CalculatorPage()),
  ],
);
