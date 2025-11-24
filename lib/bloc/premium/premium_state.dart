part of 'premium_bloc.dart';

class PremiumState extends Equatable {
  final ApiResponse apiResponse;
  final PremiumPlanModel premiumPlanModel;
  final SubscribePlanModel subscribePlanModel;
  const PremiumState({
    this.apiResponse = const ApiResponse.initial(),
    this.premiumPlanModel = const PremiumPlanModel(),
    this.subscribePlanModel = const SubscribePlanModel(),
  });

  PremiumState copyWith({
    final ApiResponse? apiResponse,
    final SubscribePlanModel? subscribePlanModel,
    final PremiumPlanModel? premiumPlanModel,
  }) {
    return PremiumState(
      apiResponse: apiResponse ?? this.apiResponse,
      premiumPlanModel: premiumPlanModel ?? this.premiumPlanModel,
      subscribePlanModel: subscribePlanModel ?? this.subscribePlanModel,
    );
  }

  @override
  List<Object> get props => [apiResponse, premiumPlanModel, subscribePlanModel];
}
