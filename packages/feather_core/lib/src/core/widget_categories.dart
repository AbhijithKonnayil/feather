import 'enum.dart';

abstract class WidgetCategory implements LabeledEnum {}

enum ComponentCategory implements WidgetCategory {
  formsInputs('Forms & Inputs'),
  navigation('Navigation'),
  feedback('Feedback'),
  overlays('Overlays'),
  dataDisplay('Data Display'),
  layoutStructure('Layout & Structure'),
  typography('Typography'),
  media('Media');

  const ComponentCategory(this.label);

  @override
  final String label;
}

enum BlockCategory implements WidgetCategory {
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

  const BlockCategory(this.label);

  @override
  final String label;
}

enum PageCategory implements WidgetCategory {
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

  const PageCategory(this.label);

  @override
  final String label;
}
