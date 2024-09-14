import 'package:flutter/material.dart';
import 'package:job_vacancy/utilities/generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String content,
}) async {
  await showGenericDialog<void>(
    title: 'Error Appeared',
    content: content,
    context: context,
    buttonOptions: () => {
      'OK': null,
    },
  );
}
