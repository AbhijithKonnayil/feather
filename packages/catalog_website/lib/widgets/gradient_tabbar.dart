import 'package:flutter/material.dart';

class GradientTabBar extends StatelessWidget implements PreferredSizeWidget {
  const GradientTabBar({
    required this.tabController,
    required this.pageController,
    required this.tabs,
    super.key,
  });
  final PageController pageController;
  final List<String> tabs;
  final TabController tabController;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00C9A7), Color(0xFF0072FF)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TabBar(
        dividerHeight: 0,

        controller: tabController,
        tabs: tabs
            .map((e) => Tab(child: Text(e, style: theme.textTheme.bodyLarge)))
            .toList(),
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        indicator: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),

        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: theme.colorScheme.onSurface,
        unselectedLabelColor: Colors.white,
        //indicatorColor: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
