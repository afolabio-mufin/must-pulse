import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/analytics/analytics_page.dart';
import 'features/assessment/assessment_page.dart';
import 'features/calculator/calculator_page.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/landing/landing_page.dart';
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
    GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsPage()),
    GoRoute(path: '/calculator', builder: (_, __) => const CalculatorPage()),
  ],
);
