import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/models.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/mock_data.dart';
import '../../shared/widgets/stat_card.dart';

/// AI Skill Assessment: individual and team analytics, filters, search, and insights.
class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  final List<AssessmentResult> _allResults = MockData.assessmentResults;
  String _viewMode = 'individual'; // 'individual' | 'team'
  String _searchQuery = '';
  String? _teamFilter;
  String? _skillLevelFilter;
  AssessmentResult? _selectedMember;

  List<AssessmentResult> get _filteredResults {
    var list = List<AssessmentResult>.from(_allResults);
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((r) {
        return r.userName.toLowerCase().contains(q) ||
            r.team.toLowerCase().contains(q);
      }).toList();
    }
    if (_teamFilter != null && _teamFilter!.isNotEmpty) {
      list = list.where((r) => r.team == _teamFilter).toList();
    }
    if (_skillLevelFilter != null && _skillLevelFilter!.isNotEmpty) {
      list = list.where((r) => r.skillLevel == _skillLevelFilter).toList();
    }
    return list;
  }

  Set<String> get _teams =>
      _allResults.map((r) => r.team).toSet()..removeWhere((e) => e.isEmpty);

  Set<String> get _skillLevels =>
      _allResults.map((r) => r.skillLevel).toSet();

  /// Team-level aggregate for group analytics
  Map<String, _TeamAggregate> get _teamAggregates {
    final map = <String, _TeamAggregate>{};
    for (final r in _filteredResults) {
      map.putIfAbsent(r.team, () => _TeamAggregate(teamName: r.team));
      final agg = map[r.team]!;
      agg.members.add(r);
      agg.totalScore += r.overallScore;
      agg.count += 1;
    }
    for (final agg in map.values) {
      agg.averageScore =
          agg.count > 0 ? agg.totalScore / agg.count : 0.0;
    }
    return map;
  }

  List<_TeamAggregate> get _teamList {
    final list = _teamAggregates.values.toList();
    list.sort((a, b) => b.averageScore.compareTo(a.averageScore));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredResults;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0C1222), Color(0xFF0F172A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsRow(context, filtered),
                      const SizedBox(height: 24),
                      _buildFiltersAndViewToggle(context),
                      const SizedBox(height: 24),
                      if (_viewMode == 'individual') ...[
                        _buildIndividualSection(context, filtered),
                      ] else ...[
                        _buildTeamSection(context),
                      ],
                      if (_selectedMember != null) ...[
                        const SizedBox(height: 32),
                        _buildScoreCard(context, _selectedMember!),
                        const SizedBox(height: 24),
                        _buildRadarChart(context, _selectedMember!),
                        const SizedBox(height: 24),
                        _buildRecommendations(context, _selectedMember!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 32, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Skill Assessment',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Individual and team analytics · Filters and search',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, List<AssessmentResult> filtered) {
    final avgScore = filtered.isEmpty
        ? 0.0
        : filtered.fold<double>(0, (s, r) => s + r.overallScore) /
            filtered.length;
    final levelCounts = <String, int>{};
    for (final r in filtered) {
      levelCounts[r.skillLevel] = (levelCounts[r.skillLevel] ?? 0) + 1;
    }
    final topLevel = levelCounts.entries.isNotEmpty
        ? levelCounts.entries
            .reduce((a, b) => a.value >= b.value ? a : b)
            .key
        : '—';

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 700 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: cols,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.0,
          children: [
            StatCard(
              title: 'Members assessed',
              value: '${filtered.length}',
              subtitle: _teamFilter != null ? 'In $_teamFilter' : 'All teams',
              icon: Icons.people_rounded,
              color: AppTheme.primary,
            ),
            StatCard(
              title: 'Average score',
              value: '${avgScore.toStringAsFixed(1)}%',
              subtitle: filtered.isEmpty ? '—' : 'Across filtered set',
              icon: Icons.trending_up_rounded,
              color: AppTheme.success,
            ),
            StatCard(
              title: 'Teams',
              value: '${_teams.length}',
              subtitle: 'With assessment data',
              icon: Icons.groups_rounded,
              color: AppTheme.secondary,
            ),
            StatCard(
              title: 'Most common level',
              value: topLevel,
              subtitle: 'In filtered results',
              icon: Icons.emoji_events_rounded,
              color: AppTheme.warning,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFiltersAndViewToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'View',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(width: 16),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'individual',
                    label: Text('Individual'),
                    icon: Icon(Icons.person_rounded, size: 18),
                  ),
                  ButtonSegment(
                    value: 'team',
                    label: Text('Team / Group'),
                    icon: Icon(Icons.groups_rounded, size: 18),
                  ),
                ],
                selected: {_viewMode},
                onSelectionChanged: (Set<String> s) {
                  setState(() {
                    _viewMode = s.first;
                    _selectedMember = null;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppTheme.primary.withValues(alpha: 0.25);
                    }
                    return AppTheme.bgElevated;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppTheme.primary;
                    }
                    return AppTheme.textSecondary;
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: const InputDecoration(
              hintText: 'Search by name or team…',
              prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textMuted),
              isDense: true,
            ),
            style: const TextStyle(color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Team',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _teamFilter,
                hint: const Text('All teams'),
                dropdownColor: AppTheme.bgCard,
                underline: const SizedBox(),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('All teams'),
                  ),
                  ..._teams.map(
                    (t) => DropdownMenuItem<String>(
                      value: t,
                      child: Text(t),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _teamFilter = v),
              ),
              const SizedBox(width: 24),
              Text(
                'Skill level',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _skillLevelFilter,
                hint: const Text('All levels'),
                dropdownColor: AppTheme.bgCard,
                underline: const SizedBox(),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('All levels'),
                  ),
                  ..._skillLevels.map(
                    (s) => DropdownMenuItem<String>(
                      value: s,
                      child: Text(s),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _skillLevelFilter = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualSection(
      BuildContext context, List<AssessmentResult> filtered) {
    // Sort by score descending
    final sorted = List<AssessmentResult>.from(filtered)
      ..sort((a, b) => b.overallScore.compareTo(a.overallScore));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members (${sorted.length}) — click for detail',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.border, width: 0.5),
          ),
          child: Column(
            children: [
              _tableHeader(context),
              ...sorted.asMap().entries.map(
                    (e) => _memberRow(context, e.value, e.key + 1),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.bgElevated,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '#',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              'Name',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'Team',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            width: 72,
            child: Text(
              'Score',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Level',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberRow(BuildContext context, AssessmentResult r, int rank) {
    final isSelected = _selectedMember?.id == r.id;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedMember = r),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(color: AppTheme.border, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  '$rank',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textMuted,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Text(
                  r.userName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  r.team,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Text(
                  '${r.overallScore.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(
                width: 100,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _levelColor(r.skillLevel)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    r.skillLevel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _levelColor(r.skillLevel),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'AI Native':
        return AppTheme.primary;
      case 'Expert':
        return AppTheme.success;
      case 'Advanced':
        return AppTheme.accent;
      case 'Intermediate':
        return AppTheme.warning;
      default:
        return AppTheme.textMuted;
    }
  }

  Widget _buildTeamSection(BuildContext context) {
    final teams = _teamList;
    if (teams.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.border),
        ),
        child: Center(
          child: Text(
            'No team data for current filters.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textMuted,
                ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team / group analytics',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < teams.length) {
                        final name = teams[value.toInt()].teamName;
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            name.length > 12
                                ? '${name.substring(0, 10)}…'
                                : name,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    reservedSize: 44,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (v, _) => Text(
                      v.toInt().toString(),
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 25,
                getDrawingHorizontalLine: (v) => FlLine(
                  color: AppTheme.border.withValues(alpha: 0.5),
                  strokeWidth: 0.5,
                ),
              ),
              barGroups: teams.asMap().entries.map((e) {
                final colors = AppTheme.chartColors;
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value.averageScore.clamp(0.0, 100.0),
                      color: colors[e.key % colors.length],
                      width: 28,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Team breakdown',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        ...teams.map((agg) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.border, width: 0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        agg.teamName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Text(
                      '${agg.count} member${agg.count == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textMuted,
                          ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${agg.averageScore.toStringAsFixed(1)}% avg',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildScoreCard(BuildContext context, AssessmentResult result) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Overall Score',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '${result.overallScore.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 60,
            color: AppTheme.border,
          ),
          Column(
            children: [
              Text(
                'Skill Level',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.4)),
                ),
                child: Text(
                  result.skillLevel,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadarChart(BuildContext context, AssessmentResult result) {
    final categories = result.categoryScores.entries.toList();
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 320,
            child: RadarChart(
              RadarChartData(
                dataSets: [
                  RadarDataSet(
                    fillColor: AppTheme.primary.withValues(alpha: 0.2),
                    borderColor: AppTheme.primary,
                    borderWidth: 2,
                    dataEntries: List<RadarEntry>.from(
                      categories.map((e) => RadarEntry(value: e.value / 100)),
                    ),
                  ),
                ],
                radarShape: RadarShape.polygon,
                tickCount: 4,
                getTitle: (i, _) => RadarChartTitle(
                  text: categories[i].key
                      .replaceAll(' ', '\n')
                      .split('\n')
                      .take(2)
                      .join('\n'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(
      BuildContext context, AssessmentResult result) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personalized recommendations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 20),
          ...result.recommendations.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${e.key + 1}',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      e.value,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TeamAggregate {
  _TeamAggregate({
    required this.teamName,
  })  : members = [],
        totalScore = 0,
        count = 0;

  final String teamName;
  final List<AssessmentResult> members;
  double totalScore;
  int count;
  late double averageScore;
}
