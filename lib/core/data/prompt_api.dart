import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

/// Base URL for the MUST AI Pulse backend (e.g. http://localhost:3001).
/// Set to null or empty to use mock data only.
const String kPromptApiBaseUrl = String.fromEnvironment(
  'MUST_PULSE_API_URL',
  defaultValue: 'http://localhost:3001',
);

class PromptApi {
  PromptApi({this.baseUrl = kPromptApiBaseUrl});

  final String baseUrl;

  /// Fetches prompts from the backend. Returns empty list on error (caller can fall back to mock).
  Future<List<PromptEntry>> getPrompts() async {
    if (baseUrl.isEmpty) return [];
    try {
      final uri = Uri.parse('$baseUrl/api/prompts');
      final response = await http.get(uri).timeout(
            const Duration(seconds: 3),
            onTimeout: () => throw Exception('timeout'),
          );
      if (response.statusCode != 200) return [];
      final list = jsonDecode(response.body) as List<dynamic>?;
      if (list == null || list.isEmpty) return [];
      return list.map((e) => _entryFromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  static PromptEntry _entryFromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    DateTime? dt;
    if (createdAt != null) {
      if (createdAt is String) dt = DateTime.tryParse(createdAt);
    }
    final tags = json['tags'];
    return PromptEntry(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      category: json['category'] as String? ?? 'Cursor Rules',
      author: json['author'] as String? ?? '',
      team: json['team'] as String? ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      createdAt: dt,
      tags: tags is List<dynamic> ? tags.map((e) => e.toString()).toList() : const [],
    );
  }
}
