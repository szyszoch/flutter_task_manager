import 'package:flutter/material.dart';

Widget buildFormErrorText(
  BuildContext context,
  String errorText, {
  bool isCustomField = false,
}) {
  Widget row = Row(
    spacing: 5,
    children: [
      const Icon(Icons.warning_rounded, color: Colors.red),
      Expanded(
        child: Text(
          errorText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    ],
  );

  if (isCustomField) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: row,
    );
  }

  return row;
}
