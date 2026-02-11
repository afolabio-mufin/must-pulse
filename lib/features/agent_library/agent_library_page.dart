import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/models.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/mock_data.dart';
import '../../shared/widgets/stat_card.dart';

/// Agent Library: dedicated screen for AI agents (Planning, Debugger, QA, Design, etc.).
/// Separate from Prompt Vault; focused on discoverability, adoption, and usage.
class AgentLibraryPage extends StatefulWidget {
  const AgentLibraryPage({super.key});

  @override
  State<AgentLibraryPage> createState() => _AgentLibraryPageState();
}

class _AgentLibraryPageState extends State<AgentLibraryPage> {
  final List<AgentLibraryEntry> _agents = MockData.agentLibraryEntries;
  String _searchQuery = '';
  String? _categoryFilter;
  String _sortBy = 'usage'; // usage, rating, adoption, name

  List<AgentLibraryEntry> get _filteredAgents {
    var list = List<AgentLibraryEntry>.from(_agents);
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((a) {
        return a.name.toLowerCase().contains(q) ||
            a.shortDescription.toLowerCase().contains(q) ||
            a.category.toLowerCase().contains(q) ||
            a.tags.any((t) => t.toLowerCase().contains(q));
      }).toList();
    }
    if (_categoryFilter != null && _categoryFilter!.isNotEmpty) {
      list = list.where((a) => a.category == _categoryFilter).toList();
    }
    switch (_sortBy) {
      case 'rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'adoption':
        list.sort((a, b) => b.adoptionCount.compareTo(a.adoptionCount));
        break;
      case 'name':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
        list.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    }
    return list;
  }

  Set<String> get _categories =>
      _agents.map((a) => a.category).toSet()..removeWhere((e) => e.isEmpty);

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredAgents;
    final totalUsage =
        _agents.fold<int>(0, (s, a) => s + a.usageCount);
    final totalAdoption =
        _agents.fold<int>(0, (s, a) => s + a.adoptionCount);

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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
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
                              'Agent Library',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text(
                              'Discover, adopt, and use AI agents across Planning, Debugging, QA, Design & Code Review',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.textMuted,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Stats row
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cols = constraints.maxWidth > 700 ? 4 : 2;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: cols,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2.2,
                        children: [
                          StatCard(
                            title: 'Total Agents',
                            value: '${_agents.length}',
                            subtitle: 'In library',
                            icon: Icons.smart_toy_rounded,
                            color: AppTheme.primary,
                          ),
                          StatCard(
                            title: 'Total Uses',
                            value: _formatNumber(totalUsage),
                            subtitle: 'All time',
                            icon: Icons.touch_app_rounded,
                            color: AppTheme.secondary,
                          ),
                          StatCard(
                            title: 'Teams Adopted',
                            value: '$totalAdoption',
                            subtitle: 'Across org',
                            icon: Icons.groups_rounded,
                            color: AppTheme.success,
                          ),
                          StatCard(
                            title: 'Categories',
                            value: '${_categories.length}',
                            subtitle: 'Planning, QA, Design…',
                            icon: Icons.category_rounded,
                            color: AppTheme.accent,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              // Search + filters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search agents by name, category, or tag…',
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.textMuted,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  onPressed: () =>
                                      setState(() => _searchQuery = ''),
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: AppTheme.textMuted,
                                  ),
                                )
                              : null,
                        ),
                        style: const TextStyle(color: AppTheme.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Category',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          const SizedBox(width: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _FilterChip(
                                label: 'All',
                                selected: _categoryFilter == null,
                                onTap: () =>
                                    setState(() => _categoryFilter = null),
                              ),
                              ..._categories.map(
                                (c) => _FilterChip(
                                  label: c,
                                  selected: _categoryFilter == c,
                                  onTap: () =>
                                      setState(() => _categoryFilter = c),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Sort by',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          const SizedBox(width: 12),
                          ...['usage', 'rating', 'adoption', 'name'].map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(_sortLabel(s)),
                                selected: _sortBy == s,
                                onSelected: (_) =>
                                    setState(() => _sortBy = s),
                                selectedColor: AppTheme.primary
                                    .withValues(alpha: 0.25),
                                side: BorderSide(
                                  color: _sortBy == s
                                      ? AppTheme.primary
                                      : AppTheme.border,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              // Results count
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    '${filtered.length} agent${filtered.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              // Agent cards
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final agent = filtered[index];
                      return _AgentCard(
                        agent: agent,
                        onTap: () => context.push(
                          '/agent-library/detail',
                          extra: agent,
                        ),
                      );
                    },
                    childCount: filtered.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 48)),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }

  String _sortLabel(String s) {
    switch (s) {
      case 'usage':
        return 'Most used';
      case 'rating':
        return 'Top rated';
      case 'adoption':
        return 'Most adopted';
      case 'name':
        return 'A–Z';
      default:
        return s;
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary.withValues(alpha: 0.2)
              : AppTheme.bgElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppTheme.primary : AppTheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppTheme.primary : AppTheme.textSecondary,
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  const _AgentCard({required this.agent, required this.onTap});

  final AgentLibraryEntry agent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.border, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.smart_toy_rounded,
                        color: AppTheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondary
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  agent.category,
                                  style: const TextStyle(
                                    color: AppTheme.secondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'v${agent.version}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppTheme.textMuted,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            agent.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppTheme.textMuted,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  agent.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.45,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _Metric(
                      icon: Icons.star_rounded,
                      value: agent.rating.toStringAsFixed(1),
                      label: 'Rating',
                      color: AppTheme.warning,
                    ),
                    const SizedBox(width: 20),
                    _Metric(
                      icon: Icons.touch_app_rounded,
                      value: '${agent.usageCount}',
                      label: 'Uses',
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 20),
                    _Metric(
                      icon: Icons.groups_rounded,
                      value: '${agent.adoptionCount}',
                      label: 'Teams',
                      color: AppTheme.success,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: agent.tags.take(5).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.bgElevated,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '#$t',
                        style: const TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Text(
                  '${agent.author} · ${agent.ownerTeam}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
