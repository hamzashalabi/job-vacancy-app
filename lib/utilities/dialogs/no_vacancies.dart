import 'package:flutter/material.dart';
import 'package:job_vacancy/utilities/generic_dialog.dart';

Future<void> showNoVacanciesDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenericDialog<void>(
    title: 'No Vacancies',
    content: content,
    context: context,
    buttonOptions: () => {
      'OK': null,
    },
  );
}
