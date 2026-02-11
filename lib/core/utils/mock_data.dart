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
        AssessmentResult(
          userName: 'Global Frontend',
          team: 'Global Frontend',
          categoryScores: {
            'AI Code Generation': 78.0,
            'Prompt Engineering': 72.0,
            'Agent Architecture': 65.0,
            'Cursor/Copilot Mastery': 82.0,
          },
          overallScore: 74.0,
          completedAt: DateTime.now(),
          recommendations: [
            'Explore advanced agent patterns',
            'Share cursor rules in Prompt Vault',
          ],
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
      ];
}
