// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:feather_generator/feather_generator.dart';
import 'package:test/test.dart';

void main() {
  group('FeatherGenerator', () {
    test('can be instantiated', () {
      expect(FeatherGenerator(), isNotNull);
    });
  });
}
