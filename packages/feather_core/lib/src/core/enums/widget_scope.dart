import 'enum.dart';

enum WidgetScope implements LabeledEnum {
  component('Component'),
  block('Block'),
  page('Page');

  const WidgetScope(this.label);

  @override
  final String label;
}
