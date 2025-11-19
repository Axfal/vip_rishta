part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ApiResponse<String> apiResponse;
  final UserProfileModel userProfileModel;

  const ProfileState({
    this.apiResponse = const ApiResponse.initial(),
    this.userProfileModel = const UserProfileModel(),
  });

  ProfileState copyWith({
    ApiResponse<String>? apiResponse,
    UserProfileModel? userProfileModel,
  }) {
    return ProfileState(
      apiResponse: apiResponse ?? this.apiResponse,
      userProfileModel: userProfileModel ?? this.userProfileModel,
    );
  }

  @override
  List<Object?> get props => [apiResponse, userProfileModel];
}
