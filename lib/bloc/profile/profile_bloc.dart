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
  final ProfileApiRepo profileApiRepo;

  ProfileBloc({required this.profileApiRepo}) : super(const ProfileState()) {
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
        final UserProfileModel profileModel = UserProfileModel.fromJson(response);

        emit(state.copyWith(
          userProfileModel: profileModel,
          apiResponse: ApiResponse.completed('Data fetched successfully'),
        ));
      } else {
        emit(state.copyWith(
          apiResponse: ApiResponse.error(response['error'] ?? "Unknown Error"),
        ));
      }
    } catch (e) {
      print('Error: $e');
      emit(state.copyWith(apiResponse: ApiResponse.error("Something went wrong")));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final Map<String, dynamic> data = {};

      void putIfNotEmpty(String key, dynamic value) {
        if (value != null) {
          if (value is String) {
            if (value.trim().isNotEmpty) data[key] = value.trim();
          } else {
            data[key] = value;
          }
        }
      }

      putIfNotEmpty('first_name', event.firstName);
      putIfNotEmpty('last_name', event.lastName);
      putIfNotEmpty('gender', event.gender);
      putIfNotEmpty('date_of_birth', event.dateOfBirth);
      putIfNotEmpty('religion', event.religion);
      putIfNotEmpty('community', event.community);
      putIfNotEmpty('country', event.country);
      putIfNotEmpty('state', event.state);
      putIfNotEmpty('city', event.city);
      putIfNotEmpty('height', event.height);
      putIfNotEmpty('diet', event.diet);
      putIfNotEmpty('hobbies', event.hobbies);
      putIfNotEmpty('qualification', event.qualification);
      putIfNotEmpty('field_of_study', event.fieldOfStudy);
      putIfNotEmpty('university', event.university);
      putIfNotEmpty('passing_year', event.passingYear);
      putIfNotEmpty('job', event.job);
      putIfNotEmpty('work_location', event.workLocation);
      putIfNotEmpty('job_type', event.jobType);
      putIfNotEmpty('marital_status', event.maritalStatus);
      putIfNotEmpty('children', event.children);

      data['id'] = SessionController.user.user!.id.toString();

      final response = await profileApiRepo.updateProfile(data, event.image);

      if (response['success'] == true && response['user'] != null) {
        final UserProfileModel updated = UserProfileModel.fromJson(response);

        emit(state.copyWith(
          userProfileModel: updated,
          apiResponse: ApiResponse.completed('Profile updated successfully'),
        ));
      } else {
        emit(state.copyWith(
          apiResponse: ApiResponse.error(response['error'] ?? 'Update failed'),
        ));
      }
    } catch (e) {
      print('Update error: $e');
      emit(state.copyWith(apiResponse: ApiResponse.error('Something went wrong')));
    }
  }
}
