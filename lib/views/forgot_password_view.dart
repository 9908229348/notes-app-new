import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/uiconstants.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_event.dart';
import 'package:notes_app/services/auth/bloc/auth_state.dart';
import 'package:notes_app/utilities/dialogs/error_dialog.dart';
import 'package:notes_app/utilities/dialogs/password_reset_email-sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSEntDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
                context: context,
                text:
                    'We could not process your request. Please make sure that you are a registered user');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(paddingValue),
          child: Column(children: [
            const Text(
                'If You forgot your password, simply enter your email and we will sent you a password reset email'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Your Email address...'),
            ),
            TextButton(
              onPressed: () {
                final email = _controller.text;
                context
                    .read<AuthBloc>()
                    .add(AuthEventForgotPassword(email: email));
              },
              child: const Text('Send me password reset link'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogout());
              },
              child: const Text('Back to login page'),
            )
          ]),
        ),
      ),
    );
  }
}
