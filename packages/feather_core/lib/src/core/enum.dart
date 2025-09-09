enum WidgetComponent {
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

  /// Constructor
  const WidgetComponent(this.label);

  /// Human-friendly display label
  final String label;
}

enum WidgetGroup {
  formsInputs('Forms & Inputs'),
  navigation('Navigation'),
  feedback('Feedback'),
  overlays('Overlays'),
  dataDisplay('Data Display'),
  layoutStructure('Layout & Structure'),
  typography('Typography'),
  media('Media');

  const WidgetGroup(this.label);

  final String label;
}
