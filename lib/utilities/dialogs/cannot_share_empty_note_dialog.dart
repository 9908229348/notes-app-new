import 'package:flutter/cupertino.dart';
import 'package:notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    content: 'You cannot share an empty note!',
    title: 'Sharing',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
