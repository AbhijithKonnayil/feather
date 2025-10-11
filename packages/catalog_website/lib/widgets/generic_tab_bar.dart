import 'package:flutter/material.dart';

/// A generic tab bar that works with any enum that implements LabeledEnum.
///
/// Example usage:
/// ```dart
/// GenericTabBar<WidgetScope>(
///   items: WidgetScope.values.toList(),
///   selectedItem: selectedScope,
///   onItemSelected: (scope) => ref.read(selectedScopeProvider.notifier).state = scope,
///   iconBuilder: (item) => _getScopeIcon(item),
/// )
/// ```
class GenericTabBar<T extends Enum> extends StatefulWidget {
  /// Creates a generic tab bar.
  ///
  /// - [items]: List of enum values to display as tabs
  /// - [initialValue]: Currently selected enum value
  /// - [onItemSelected]: Callback when a tab is selected
  /// - [iconBuilder]: Optional builder for the tab icon
  /// - [labelBuilder]: Optional builder for the tab label (defaults to enum name)
  /// - [spacing]: Horizontal spacing between tabs (defaults to 4)
  /// - [padding]: Padding around each tab (defaults to EdgeInsets.symmetric(horizontal: 16, vertical: 8))
  /// - [selectedColor]: Color for the selected tab (defaults to primary color with 0.1 opacity)
  const GenericTabBar({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onItemSelected,
    this.iconBuilder,
    this.labelBuilder,
    this.spacing = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.selectedColor,
    this.unselectedColor = Colors.transparent,
    this.borderRadius = 8.0,
  });

  final List<T> items;
  final T initialValue;
  final ValueChanged<T> onItemSelected;
  final Widget Function(T item)? iconBuilder;
  final String Function(T item)? labelBuilder;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final Color? selectedColor;
  final Color unselectedColor;
  final double borderRadius;

  @override
  State<GenericTabBar<T>> createState() => _GenericTabBarState<T>();
}

class _GenericTabBarState<T extends Enum> extends State<GenericTabBar<T>> {
  T? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedBgColor =
        widget.selectedColor ?? theme.colorScheme.primary.withOpacity(0.1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in widget.items) ...[
          if (item != widget.items.first) SizedBox(width: widget.spacing),
          _TabItem<T>(
            item: item,
            isSelected: item == selectedValue,
            onTap: () {
              widget.onItemSelected(item);
              setState(() {
                selectedValue = item;
              });
            },
            iconBuilder: widget.iconBuilder,
            labelBuilder: widget.labelBuilder,
            padding: widget.padding,
            selectedColor: selectedBgColor,
            unselectedColor: widget.unselectedColor,
            borderRadius: widget.borderRadius,
          ),
        ],
      ],
    );
  }
}

class _TabItem<T> extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.iconBuilder,
    this.labelBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.transparent,
    this.borderRadius = 8.0,
  });

  final T item;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget Function(T item)? iconBuilder;
  final String Function(T item)? labelBuilder;
  final EdgeInsetsGeometry padding;
  final Color selectedColor;
  final Color unselectedColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Material(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconBuilder != null) ...[
                    iconBuilder!(item),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    _getLabel(item),
                    style: textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          height: 3,
          width: 24,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  String _getLabel(T item) {
    if (labelBuilder != null) {
      return labelBuilder!(item);
    }
    // Default to enum name if no labelBuilder provided
    return item.toString().split('.').last;
  }
}
