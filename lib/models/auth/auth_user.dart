import 'package:equatable/equatable.dart';

/// Domain representation of the authenticated user. Kept deliberately small —
/// add fields as features need them.
class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
  });

  final String id;
  final String email;
  final String? displayName;

  @override
  List<Object?> get props => [id, email, displayName];
}
