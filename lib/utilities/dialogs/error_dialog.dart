import 'package:flutter/cupertino.dart';
import 'package:notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String text,
}) {
  return showGenericDialog(
    context: context,
    content: text,
    title: 'An Error Occured',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
