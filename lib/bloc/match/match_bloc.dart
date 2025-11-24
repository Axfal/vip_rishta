// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/match/match_model.dart';
import 'package:rishta_app/repo/activity/activity_api_repo.dart';

import '../../model/match/partner_preferences.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final ActivityApiRepo activityApiRepo;

  MatchBloc({required this.activityApiRepo}) : super(MatchState()) {
    on<SuggestedMatchEvent>(_onSuggestedMatch);
  }

  Future<void> _onSuggestedMatch(
    SuggestedMatchEvent event,
    Emitter<MatchState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final response = await activityApiRepo.suggestedMatch();

      if (response == null) {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error("No response from server"),
          ),
        );
        return;
      }

      if (response['success'] == true && response['results'] != null) {
        final matchModel = MatchModel.fromJson(response);

        emit(
          state.copyWith(
            matchModel: matchModel,
            apiResponse: ApiResponse.completed("Data fetched successfully"),
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error(
              response['error'] ?? "Error while fetching data",
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print("MatchBloc Error: $e");
      print(stackTrace);

      emit(
        state.copyWith(
          apiResponse: ApiResponse.error("Something went wrong. Try again."),
        ),
      );
    }
  }

  Future<void> _onPartnerPreference(
    PartnerPreferencesEvent event,
    Emitter<MatchState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      Map<String, dynamic> data = {
        "min_age": event.partnerPreferenceModel.minAge,
        "max_age": event.partnerPreferenceModel.maxAge,
        "preferred_city": event.partnerPreferenceModel.preferredCity,
        "preferred_religion": event.partnerPreferenceModel.preferredReligion,
        "preferred_education": event.partnerPreferenceModel.preferredEducation,
        "preferred_job": event.partnerPreferenceModel.preferredJob,
        "preferred_marital_status":
            event.partnerPreferenceModel.preferredMaritalStatus,
      };
      final response = await activityApiRepo.partnerPreference(data);
      if (response == null) {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error("No response from server"),
          ),
        );
        return;
      }

      if (response['success'] == true && response['results'] != null) {
        final matchModel = MatchModel.fromJson(response);

        emit(
          state.copyWith(
            matchModel: matchModel,
            apiResponse: ApiResponse.completed("Data fetched successfully"),
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error(
              response['error'] ?? "Error while fetching data",
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print("MatchBloc Error: $e");
      print(stackTrace);

      emit(
        state.copyWith(
          apiResponse: ApiResponse.error("Something went wrong. Try again."),
        ),
      );
    }
  }
}
