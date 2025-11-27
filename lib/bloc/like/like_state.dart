part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiResponse apiResponse;
  final LikedProfileModel likedProfileModel;
  const LikeState({
    this.apiResponse = const ApiResponse.initial(),
    this.likedProfileModel = const LikedProfileModel(),
  });

  LikeState copyWith({
    final ApiResponse? apiResponse,
    final LikedProfileModel? likedProfileModel,
  }) {
    return LikeState(
      apiResponse: apiResponse ?? this.apiResponse,
      likedProfileModel: likedProfileModel ?? this.likedProfileModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [apiResponse, likedProfileModel];
}
