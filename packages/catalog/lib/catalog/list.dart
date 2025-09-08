import 'package:flutter/material.dart';

class WidgetMeta {
  final Widget widget;
  final String name;
  WidgetMeta({required this.widget, required this.name});
  String get installCommand => 'feather add $name';
}

final Map<String, List<WidgetMeta>> widgetsByCategory = {
  'Buttons': [
    WidgetMeta(
      widget: ElevatedButton(
        onPressed: () {},
        child: const Text('Elevated Btn'),
      ),
      name: 'ElevatedButton',
    ),
    WidgetMeta(
      widget: OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
      name: 'OutlinedButton',
    ),
    WidgetMeta(
      widget: TextButton(onPressed: () {}, child: const Text('Text')),
      name: 'TextButton',
    ),
    WidgetMeta(
      widget: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        heroTag: 'fab1',
      ),
      name: 'FloatingActionButton',
    ),
  ],
  'TextFields': [
    WidgetMeta(
      widget: const TextField(
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
      ),
      name: 'Name TextField',
    ),
    WidgetMeta(
      widget: const TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
      ),
      name: 'Email TextField',
    ),
    WidgetMeta(
      widget: const TextField(
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.visibility_off),
        ),
        obscureText: true,
      ),
      name: 'Password TextField',
    ),
  ],
};
