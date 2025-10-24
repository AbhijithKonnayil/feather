import 'package:feather_core/feather_core.dart';
import 'package:flutter/material.dart';

part 'formly_contact_form.example.dart';

@BlockMeta(
  id: 'formly_contact_form',
  name: 'Formly Contact Form',
  description: 'A simple FormlyContactForm component for demo',
  files: [],
  //TODO: add screen types
  screens: [Screens.mobile, Screens.tablet],
  //TODO: add types
  types: [BlockType.cardBlock, BlockType.formBlock],
  //TODO: add categories
  categories: [BlockCategory.cardBlock],
)
class FormlyContactForm extends StatefulWidget {
  const FormlyContactForm({super.key});

  @override
  State<FormlyContactForm> createState() => _FormlyContactFormState();
}

class _FormlyContactFormState extends State<FormlyContactForm> {
  final emailController = TextEditingController(text: 'johndoe@gmail.com');

  final nameController = TextEditingController(text: 'John Doe');

  final contactNoController = TextEditingController(text: '1234567890');

  final subjectController = TextEditingController(
    text: 'Formly Test',
  );
  final messageController = TextEditingController(
    text: 'Your form is ready to be submitted.',
  );
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            FTextField(
              controller: emailController,
              hintText: 'Email',
              labelText: 'Email',
            ),
            FTextField(
              controller: subjectController,
              hintText: 'Subject',
              labelText: 'Subject',
            ),
            FTextField(
              controller: nameController,
              hintText: 'Name',
              labelText: 'Name',
            ),
            FTextField(
              controller: contactNoController,
              hintText: 'Contact Number',
              labelText: 'Contact Number',
            ),
            FTextField(
              controller: messageController,
              hintText: 'Message',
              labelText: 'Message',
              maxLines: 3,
            ),
            GradientButton(
              text: 'Submit',
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FTextField extends StatelessWidget {
  const FTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.enabled = true,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.maxLines,
    this.labelText,
  });
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        labelText: labelText,
        // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        // border: Theme.of(context).inputDecorationTheme.border,
        //  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
      //style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.text,
    super.key,
    this.onPressed,
    this.enabled = true,
    this.borderRadius = 32,
    this.padding,
    this.gradient,
    this.isOutlineButton = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final bool isOutlineButton;
  @override
  Widget build(BuildContext context) {
    final borderRadiusCommon = BorderRadius.circular(borderRadius);
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient:
              gradient ??
              const LinearGradient(
                colors: [Color(0xFF3A8DFF), Color(0xFF27C78C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          borderRadius: borderRadiusCommon,
        ),
        child: Container(
          decoration: isOutlineButton
              ? BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: borderRadiusCommon,
                )
              : null,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: enabled ? onPressed : null,
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isOutlineButton
                          ? const Color(0xFF3A8DFF)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
