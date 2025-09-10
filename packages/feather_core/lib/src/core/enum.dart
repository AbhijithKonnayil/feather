/// A contract for enums that have a human-friendly label.
abstract class LabeledEnum {
  String get label;
}

enum WidgetComponent implements LabeledEnum {
  button('Button'),
  appBar('App Bar'),
  textField('Text Field'),
  card('Card'),
  progressBar('Progress Bar'),
  tabBar('Tab Bar'),
  bottomNavigation('Bottom Navigation'),
  progressIndicator('Progress Indicator'),
  sidebar('Sidebar'),
  charts('Charts');

  const WidgetComponent(this.label);

  @override
  final String label;
}

enum WidgetGroup implements LabeledEnum {
  formsInputs('Forms & Inputs'),
  navigation('Navigation'),
  feedback('Feedback'),
  overlays('Overlays'),
  dataDisplay('Data Display'),
  layoutStructure('Layout & Structure'),
  typography('Typography'),
  media('Media');

  const WidgetGroup(this.label);

  @override
  final String label;
}
