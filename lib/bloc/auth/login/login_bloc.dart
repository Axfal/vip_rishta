// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/auth/user_model.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApiRepo authApiRepo;

  LoginBloc({required this.authApiRepo}) : super(LoginState()) {
    on<EmailChangeEvent>(_onEmailChange);
    on<MobileChangeEvent>(_onMobileChange);
    on<PasswordChangeEvent>(_onPasswordChange);
    on<SubmitCredentials>(_onSubmitCredential);
  }

  void _onEmailChange(EmailChangeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onMobileChange(MobileChangeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(mobile: event.mobile));
  }

  void _onPasswordChange(PasswordChangeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitCredential(
    SubmitCredentials event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final Map<String, dynamic> data = {
        if (state.email.isNotEmpty) "email": state.email,
        if (state.email.isEmpty && state.mobile.isNotEmpty)
          "mobile": state.mobile,
        "password": state.password,
      };

      final response = await authApiRepo.login(data);

      if (response == null) {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error("No response from server"),
          ),
        );
        return;
      }

      if (response['success'] == true && response['user'] != null) {
        final userModel = UserModel.fromJson(response);

        emit(
          state.copyWith(
            userModel: userModel,
            apiResponse: ApiResponse.completed(
              userModel.message ?? "Login Successfully",
            ),
            email: '',
            mobile: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error(
              response['message'] ?? "Login failed",
            ),
            email: '',
            mobile: '',
            password: '',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error("Something went wrong: $e"),
        ),
      );
    }
  }
}
