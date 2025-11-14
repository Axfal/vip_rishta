part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ApiResponse<String> apiResponse;
  final UserProfileModel userProfileModel;
  const ProfileState({
    this.apiResponse = const ApiResponse.initial(),
    this.userProfileModel = const UserProfileModel(),
  });
  ProfileState copyWith({
    final ApiResponse<String>? apiResponse,
    final UserProfileModel? userProfileModel,
  }) {
    return ProfileState(
      apiResponse: apiResponse ?? this.apiResponse,
      userProfileModel: userProfileModel ?? this.userProfileModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [apiResponse, userProfileModel];
}
