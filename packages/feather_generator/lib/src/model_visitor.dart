import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor2.dart';

class ModelVisitor extends SimpleElementVisitor2<void> {
  String className = '';
  Map<String, dynamic> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final String returnType = element.returnType.toString();
    className = returnType.replaceAll("*", "");
  }

  @override
  void visitFieldElement(FieldElement element) {
    String elementType = element.type.toString().replaceAll("*", "");
    if (element.name != null) fields[element.name!] = elementType;
  }
}
