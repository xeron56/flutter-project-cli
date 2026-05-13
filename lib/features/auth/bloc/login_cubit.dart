import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app_template/features/auth/model/email.dart';
import 'package:flutter_bloc_app_template/features/auth/model/password.dart';
import 'package:formz/formz.dart';

/// Holds *form-field* state for the login screen. Submission itself goes to
/// the global `AuthBloc` — that's intentional: the form cubit is scoped to
/// the screen, while auth state outlives it.
class LoginFormState extends Equatable with FormzMixin {
  const LoginFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final Email email;
  final Password password;

  LoginFormState copyWith({Email? email, Password? password}) =>
      LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];

  @override
  List<Object?> get props => [email, password];
}

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: Email.dirty(value)));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: Password.dirty(value)));
}
