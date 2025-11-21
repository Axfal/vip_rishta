part of 'match_bloc.dart';

class MatchState extends Equatable {
  final ApiResponse apiResponse;
  final MatchModel matchModel;
  final PartnerPreferenceModel partnerPreferenceModel;
  const MatchState({
    this.apiResponse = const ApiResponse.initial(),
    this.matchModel = const MatchModel(),
    this.partnerPreferenceModel = const PartnerPreferenceModel(),
  });

  MatchState copyWith({
    final ApiResponse? apiResponse,
    final MatchModel? matchModel,
    final PartnerPreferenceModel? partnerPreferenceModel,
  }) {
    return MatchState(
      apiResponse: apiResponse ?? this.apiResponse,
      matchModel: matchModel ?? this.matchModel,
      partnerPreferenceModel:
          partnerPreferenceModel ?? this.partnerPreferenceModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [apiResponse, matchModel, partnerPreferenceModel];
}
