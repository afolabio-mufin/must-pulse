import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class VgtaMetric {
  final String id;
  final String teamName;
  final String memberName;
  final double value;
  final double gpuUsage;
  final int tokenCount;
  final double headcount;
  final DateTime period;

  VgtaMetric({
    String? id,
    required this.teamName,
    required this.memberName,
    required this.value,
    required this.gpuUsage,
    required this.tokenCount,
    required this.headcount,
    required this.period,
  }) : id = id ?? _uuid.v4();

  double get vgtaScore {
    final d = gpuUsage * tokenCount * headcount;
    return d == 0 ? 0 : value / d;
  }
}

class AssessmentResult {
  final String id;
  final String userName;
  final String team;
  final Map<String, double> categoryScores;
  final double overallScore;
  final DateTime completedAt;
  final List<String> recommendations;

  AssessmentResult({
    String? id,
    required this.userName,
    required this.team,
    required this.categoryScores,
    required this.overallScore,
    required this.completedAt,
    required this.recommendations,
  }) : id = id ?? _uuid.v4();

  String get skillLevel {
    if (overallScore >= 90) return 'AI Native';
    if (overallScore >= 75) return 'Expert';
    if (overallScore >= 60) return 'Advanced';
    if (overallScore >= 40) return 'Intermediate';
    if (overallScore >= 20) return 'Novice';
    return 'Beginner';
  }
}

class PromptEntry {
  final String id;
  final String title;
  final String content;
  final String category;
  final String author;
  final String team;
  final int rating;
  final int usageCount;
  final DateTime createdAt;
  final List<String> tags;

  PromptEntry({
    String? id,
    required this.title,
    required this.content,
    required this.category,
    required this.author,
    required this.team,
    this.rating = 0,
    this.usageCount = 0,
    DateTime? createdAt,
    this.tags = const [],
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  /// Word count for prompt analysis.
  int get wordCount =>
      content.trim().isEmpty ? 0 : content.trim().split(RegExp(r'\s+')).length;

  /// Rough token estimate (~4 chars per token for English/mixed content).
  int get estimatedTokens => (content.length / 4).ceil();

  /// Whether this prompt is longer than 500 tokens (consider splitting for some models).
  bool get isLongForm => estimatedTokens > 500;
}

/// Agent Library entry: dedicated AI agents (Planning, Debugger, QA, Design, etc.)
class AgentLibraryEntry {
  final String id;
  final String name;
  final String slug;
  final String shortDescription;
  final String fullDescription;
  final String category; // Planning, Debugger, QA, Design, Code Review, Security, etc.
  final List<String> capabilities;
  final List<String> integrations; // Cursor, Copilot, Slack, etc.
  final String author;
  final String ownerTeam;
  final double rating;
  final int usageCount;
  final int adoptionCount; // teams/members using this agent
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String version;
  final List<String> tags;
  final String promptBody; // Full system prompt / instructions
  final Map<String, String> examples; // scenario -> example output

  AgentLibraryEntry({
    String? id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.fullDescription,
    required this.category,
    this.capabilities = const [],
    this.integrations = const [],
    required this.author,
    required this.ownerTeam,
    this.rating = 0,
    this.usageCount = 0,
    this.adoptionCount = 0,
    DateTime? createdAt,
    this.updatedAt,
    this.version = '1.0.0',
    this.tags = const [],
    this.promptBody = '',
    this.examples = const {},
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();
}
