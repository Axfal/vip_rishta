part of 'premium_bloc.dart';

sealed class PremiumEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PremiumPlanEvent extends PremiumEvent{}

class SubscribePlanEvent extends PremiumEvent{}
