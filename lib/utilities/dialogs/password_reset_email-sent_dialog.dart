import 'package:flutter/cupertino.dart';
import 'package:notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSEntDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    content:
        'We have sent you a password reset link. Please check your email for more information',
    title: 'Password Reset',
    optionBuilder: () => {'OK': null},
  );
}
