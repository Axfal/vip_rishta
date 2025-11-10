// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/auth/user_model.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthApiRepo authApiRepo;

  ForgotPasswordBloc({required this.authApiRepo})
      : super(const ForgotPasswordState()) {
    on<EmailChangeEvent>(_onEmailChange);
    on<OTPChangeEvent>(_onOTPChange);
    on<RequestOTPEvent>(_onRequestOTP);
    on<VerifyOTPEvent>(_onVerifyOtp);
  }

  Future<void> _onEmailChange(
      EmailChangeEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onOTPChange(
      OTPChangeEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(otp: event.otp));
  }

  Future<void> _onRequestOTP(
      RequestOTPEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final data = {
        "otp_type": "login_otp",
        "target": state.email,
      };

      final response = await authApiRepo.forgotPassword(data);

      if (response != null && response['success'] == true) {
        emit(state.copyWith(
          apiResponse: ApiResponse.completed(
            response['message'] ?? 'OTP sent successfully via email',
          ),
        ));
      } else {
        emit(state.copyWith(apiResponse: ApiResponse.error("Failed to send OTP")));
      }
    } catch (e) {
      emit(state.copyWith(apiResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOTPEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final data = {
        "target": state.email,
        "otp_type": "login_otp",
        "code": state.otp,
      };

      final response = await authApiRepo.verifyOTP(data);

      if (response != null && response['success'] == true) {
        final userModel = UserModel.fromJson(response);

        emit(state.copyWith(
          apiResponse: ApiResponse.completed(
              response['message'] ?? 'OTP verified successfully'),
          userModel: userModel,
        ));
      } else {
        emit(state.copyWith(apiResponse: ApiResponse.error("Invalid OTP")));
      }
    } catch (e) {
      emit(state.copyWith(apiResponse: ApiResponse.error(e.toString())));
    }
  }
}
