import 'package:flutter/material.dart';

class FormActions extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const FormActions({
    super.key,
    required this.isEditing,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: const Text('Anuluj'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: onSubmit,
            child: Text(isEditing ? 'Zapisz' : 'Dodaj'),
          ),
        ),
      ],
    );
  }
}
