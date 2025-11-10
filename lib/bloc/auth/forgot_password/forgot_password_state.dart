part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final String otp;
  final UserModel userModel;
  final ApiResponse<String> apiResponse;

  const ForgotPasswordState({
    this.email = '',
    this.otp = '',
    this.userModel = const UserModel(),
    this.apiResponse = const ApiResponse.completed(''),
  });

  ForgotPasswordState copyWith({
    String? email,
    String? otp,
    UserModel? userModel,
    ApiResponse<String>? apiResponse,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      userModel: userModel ?? this.userModel,
      apiResponse: apiResponse ?? this.apiResponse,
    );
  }

  @override
  List<Object?> get props => [email, otp, apiResponse, userModel];
}
