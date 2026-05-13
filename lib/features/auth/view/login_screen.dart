import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/login_cubit.dart';
import 'package:flutter_bloc_app_template/features/auth/model/email.dart';
import 'package:flutter_bloc_app_template/features/auth/model/password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginFormCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        context.watch<AuthBloc>().state.status == AuthStatus.unknown &&
            ModalRoute.of(context)?.isCurrent == true;
    final form = context.watch<LoginFormCubit>().state;
    final authFailure = context.select<AuthBloc, String?>(
      (b) => b.state.failure?.message,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    key: const Key('login_email'),
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    onChanged: context.read<LoginFormCubit>().emailChanged,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError(form.email),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('login_password'),
                    autofillHints: const [AutofillHints.password],
                    obscureText: true,
                    onChanged: context.read<LoginFormCubit>().passwordChanged,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError(form.password),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    key: const Key('login_submit'),
                    onPressed: !form.isValid || isSubmitting
                        ? null
                        : () => context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                email: form.email.value,
                                password: form.password.value,
                              ),
                            ),
                    child: isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign in'),
                  ),
                  if (authFailure != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      authFailure,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _emailError(Email email) {
    if (email.isPure) return null;
    return switch (email.error) {
      EmailValidationError.empty => 'Email required',
      EmailValidationError.invalid => 'Enter a valid email',
      null => null,
    };
  }

  String? _passwordError(Password password) {
    if (password.isPure) return null;
    return switch (password.error) {
      PasswordValidationError.empty => 'Password required',
      PasswordValidationError.tooShort =>
        'At least ${Password.minLength} characters',
      null => null,
    };
  }
}
