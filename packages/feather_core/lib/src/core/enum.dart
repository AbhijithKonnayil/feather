/// A contract for enums that have a human-friendly label.
abstract class LabeledEnum {
  String get label;
}

enum Screens implements LabeledEnum {
  mobile('Mobile'),
  tablet('Tablet'),
  desktop('Desktop');

  const Screens(this.label);

  @override
  final String label;
}
