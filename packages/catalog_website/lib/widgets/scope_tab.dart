import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:catalog_website/widgets/generic_tab_bar.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScopeTab extends ConsumerWidget {
  const ScopeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScope = ref.watch(selectedScopeProvider);
    final notifier = ref.read(selectedScopeProvider.notifier);

    return GenericTabBar<WidgetScope>(
      items: WidgetScope.values.toList(),
      labelBuilder: (scope) => scope.name.toUpperCase(),
      initialValue: selectedScope,
      onItemSelected: (scope) => notifier.changeScope(scope),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
