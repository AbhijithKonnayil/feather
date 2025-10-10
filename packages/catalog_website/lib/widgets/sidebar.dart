import 'package:catalog_website/providers/widgets_provider.dart';
import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar>
    with TickerProviderStateMixin {
  static const double collapsedWidth = 60.0;
  static const double expandedWidth = 240.0;

  bool isExpanded = true;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogItems = ref.watch(sidebarMenuItemsProvider);
    final selectedSidebarMode = ref.watch(selectedSidebarModeProvider);
    final selectedSidebarItem = ref.watch(selectedSidebarItemProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? expandedWidth : collapsedWidth,
      curve: Curves.easeInOutCubic,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with logo and collapse button
              buildCollapseIcon(),
              ...["Widget Type", "Widget Category"].map((e) {
                var mode;
                if (e == "Widget Type") {
                  mode = WidgetType;
                } else if (e == "Widget Category") {
                  mode = WidgetCategory;
                }

                return NavItem(
                  label: e,
                  isSelected: selectedSidebarMode == mode,
                  onTap: () {
                    ref
                        .read(selectedSidebarModeProvider.notifier)
                        .changeType(mode);
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(thickness: 0.5, height: 0.5),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemCount: catalogItems.length,
                  itemBuilder: (context, index) {
                    final item = catalogItems[index];
                    return NavItem(
                      label: item.label,
                      isSelected: selectedSidebarItem == item,
                      onTap: () {
                        ref
                            .read(selectedSidebarItemProvider.notifier)
                            .changeType(item);
                      },
                    );
                  },
                ),
              ),

              // User profile or settings
              /*   Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: theme.dividerColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(Icons.person, color: theme.colorScheme.primary),
                  ),
                  title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isExpanded
                        ? Text(
                            'User Name',
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox.shrink(),
                  ),
                  trailing: isExpanded
                      ? Icon(
                          Icons.arrow_drop_down,
                          color: theme.textTheme.bodySmall?.color,
                        )
                      : null,
                  onTap: () {},
                  dense: true,
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Container buildCollapseIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(
                      begin: isExpanded ? 0.5 : 0,
                      end: isExpanded ? 0 : 0.5,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  isExpanded ? Icons.chevron_left : Icons.menu,
                  key: ValueKey<bool>(isExpanded),
                ),
              ),
              onPressed: _toggleExpanded,
              tooltip: isExpanded ? 'Collapse' : 'Expand',
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,

    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.textTheme.bodyMedium?.color,
                        fontWeight: isSelected ? FontWeight.w500 : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
