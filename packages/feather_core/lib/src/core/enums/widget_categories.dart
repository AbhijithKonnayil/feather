import 'enum.dart';

abstract class WidgetCategory implements LabeledEnum {}

enum ComponentCategory implements WidgetCategory {
  componentCategoty('Component Categoty'),
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
  blockCategoty('Block Categoty'),
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
  pageCategoty('Page Categoty'),
  auth('Authentication'),
  onboarding('Onboarding'),
  social('Social'),
  ecommerce('E-commerce'),
  dashboard('Dashboard / Analytics'),
  productivity('Productivity'),
  media('Media');

  const PageCategory(this.label);

  @override
  final String label;
}
