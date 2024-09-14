import 'package:flutter/material.dart';

// a custom dialog that lets this method call add as many buttons
// it needs with the return value of boolean
typedef ButtonsOptions<T> = Map<String, T> Function();

Future<T?> showGenericDialog<T>({
  required String title,
  required String content,
  required BuildContext context,
  required ButtonsOptions buttonOptions,
}) {
  final options = buttonOptions();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          }).toList(),
        );
      });
}
