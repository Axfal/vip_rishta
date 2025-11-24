// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/premium/premium_plan_model.dart';
import 'package:rishta_app/model/premium/subscribe_plan_model.dart';
import 'package:rishta_app/repo/premium/premium_api_repo.dart';

part 'premium_event.dart';
part 'premium_state.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  final PremiumApiRepo premiumApiRepo;

  PremiumBloc({required this.premiumApiRepo}) : super(const PremiumState()) {
    on<PremiumPlanEvent>(_onFetchPremiumPlan);
    on<SubscribePlanEvent>(_onSubscribePlan);
  }

  Future<void> _onFetchPremiumPlan(
      PremiumPlanEvent event,
      Emitter<PremiumState> emit,
      ) async {
    emit(state.copyWith(apiResponse: const ApiResponse.loading()));

    try {
      final response = await premiumApiRepo.premiumPlan();

      if (response != null) {
        if (response['success'] == true && response['plans'] != null) {
          final model = PremiumPlanModel.fromJson(response);

          emit(
            state.copyWith(
              premiumPlanModel: model,
              apiResponse: ApiResponse.completed(model),
            ),
          );

          print('Premium plans fetched successfully');
        } else {
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['error'] ?? 'Error while fetching premium plans',
              ),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error('No response from server'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error('Exception: $e'),
        ),
      );
      print('Error: $e');
    }
  }

  Future<void> _onSubscribePlan(
      SubscribePlanEvent event,
      Emitter<PremiumState> emit,
      ) async {
    emit(state.copyWith(apiResponse: const ApiResponse.loading()));

    try {
      final response = await premiumApiRepo.premiumPlan();

      if (response != null) {
        if (response['success'] == true && response['subscription'] != null) {
          final model = SubscribePlanModel.fromJson(response);

          emit(
            state.copyWith(
              subscribePlanModel: model,
              apiResponse: ApiResponse.completed(model.message ?? 'subscribed successfully'),
            ),
          );

          print(model.message ?? 'Premium plans subscribed successfully');
        } else {
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['error'] ?? 'Error while subscribing premium plans',
              ),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error('No response from server'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error('Exception: $e'),
        ),
      );
      print('Error: $e');
    }
  }

}
