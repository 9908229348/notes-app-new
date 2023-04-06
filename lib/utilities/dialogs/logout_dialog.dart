import 'package:flutter/cupertino.dart';
import 'package:notes_app/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    content: 'Are you sure you want to log out?',
    title: 'Log out',
    optionBuilder: () => {'Cancel': false, 'Log out': true},
  ).then((value) => value ?? false);
}
