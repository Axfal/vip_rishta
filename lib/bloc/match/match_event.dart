part of 'match_bloc.dart';

sealed class MatchEvent extends Equatable {
  const MatchEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuggestedMatchEvent extends MatchEvent {}

class PartnerPreferencesEvent extends MatchEvent {
  final PartnerPreferenceModel partnerPreferenceModel;
  const PartnerPreferencesEvent({required this.partnerPreferenceModel});
  @override
  // TODO: implement props
  List<Object?> get props => [partnerPreferenceModel];
}
