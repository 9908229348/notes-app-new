import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/uiconstants.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_event.dart';
import 'package:notes_app/services/auth/bloc/auth_state.dart';
import '../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;

  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context: context, text: 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseException) {
            await showErrorDialog(
                context: context, text: 'Email is already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context: context, text: 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context: context, text: 'Invalid email');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(paddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your email and password to see your notes!'),
              TextField(
                autofocus: true,
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Enter your email"),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration:
                    const InputDecoration(hintText: "Enter your password"),
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      child: const Text('Register'),
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(AuthEventRegister(
                              email,
                              password,
                            ));
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const AuthEventLogout());
                        },
                        child: const Text('Already Registered? Login here!'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
