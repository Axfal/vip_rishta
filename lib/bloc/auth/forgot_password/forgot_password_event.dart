part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class EmailChangeEvent extends ForgotPasswordEvent {
  final String email;
  const EmailChangeEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class OTPChangeEvent extends ForgotPasswordEvent {
  final String otp;
  const OTPChangeEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class RequestOTPEvent extends ForgotPasswordEvent {
  const RequestOTPEvent();

  @override
  List<Object?> get props => [];
}

class VerifyOTPEvent extends ForgotPasswordEvent {
  const VerifyOTPEvent();

  @override
  List<Object?> get props => [];
}
