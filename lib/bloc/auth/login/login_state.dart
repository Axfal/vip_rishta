part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String mobile;
  final String password;
  final UserModel userModel;
  final ApiResponse<String> apiResponse;
  const LoginState({
    this.email = '',
    this.password = '',
    this.apiResponse = const ApiResponse.completed(''),
    this.userModel = const UserModel(),
    this.mobile = '',
  });

  LoginState copyWith({
    final String? email,
    final String? mobile,
    final String? password,
    final UserModel? userModel,
    final ApiResponse<String>? apiResponse,
  }) {
    return LoginState(
      apiResponse: apiResponse ?? this.apiResponse,
      password: password ?? this.password,
      email: email ?? this.email,
      userModel: userModel ?? this.userModel,
      mobile: mobile ?? this.mobile,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, mobile, password, apiResponse, userModel];
}
