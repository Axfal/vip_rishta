// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/auth/user_profile_model.dart';
import 'package:rishta_app/repo/profile/profille_api_repo.dart';
import 'package:rishta_app/services/user_session.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileApiRepo profileApiRepo;

  ProfileBloc({required this.profileApiRepo}) : super(ProfileState()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final id = SessionController.user.user!.id.toString();
      Map<String, dynamic> data = {"id": id};

      final response = await profileApiRepo.getProfile(data);

      if (response['success'] == true && response['user'] != null) {
        final UserProfileModel profileModel = UserProfileModel.fromJson(
          response,
        );

        emit(state.copyWith(userProfileModel: profileModel));
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error(
              response['error'] ?? "Unknown Error",
            ),
          ),
        );
      }
    } catch (e) {
      print('error: $e');
      emit(
        state.copyWith(apiResponse: ApiResponse.error("Something went wrong")),
      );
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {}
}
