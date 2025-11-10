part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailChangeEvent extends LoginEvent {
  final String email;
  const EmailChangeEvent({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class MobileChangeEvent extends LoginEvent {
  final String mobile;
  const MobileChangeEvent({required this.mobile});
  @override
  // TODO: implement props
  List<Object?> get props => [mobile];
}

class PasswordChangeEvent extends LoginEvent {
  final String password;
  const PasswordChangeEvent({required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [password];
}

class SubmitCredentials extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
