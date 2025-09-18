import 'enum.dart';

abstract class WidgetType implements LabeledEnum {}

enum ComponentType implements WidgetType {
  blockCategoty('Component Type'),
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

  const ComponentType(this.label);

  @override
  final String label;
}

enum BlockType implements WidgetType {
  formBlock('Form Block'),
  cardBlock('Card Block'),
  listBlock('List Block'),
  navBlock('Navigation Block'),
  mediaBlock('Media Block'),
  statsBlock('Stats Block'),
  headerBlock('Header Block'),
  footerBlock('Footer Block'),
  gridBlock('Grid Block'),
  tableBlock('Table Block');

  const BlockType(this.label);

  @override
  final String label;
}

enum PageType implements WidgetType {
  formPage('Form Page'),
  feedPage('Feed Page'),
  dashboardPage('Dashboard Page'),
  detailPage('Detail Page'),
  listPage('List Page'),
  mediaPage('Media Page'),
  onboardingPage('Onboarding Page'),
  authPage('Authentication Page'),
  checkoutPage('Checkout Page'),
  landingPage('Landing Page');

  const PageType(this.label);

  @override
  final String label;
}
