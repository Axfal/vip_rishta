import 'package:equatable/equatable.dart';
import 'package:rishta_app/model/premium/premium_plan_model.dart';

class SubscribePlanModel extends Equatable {
  final bool? success;
  final String? message;
  final Subscription? subscription;

  const SubscribePlanModel({
    this.success,
    this.message,
    this.subscription,
  });

  factory SubscribePlanModel.fromJson(Map<String, dynamic> json) {
    return SubscribePlanModel(
      success: json['success'],
      message: json['message'],
      subscription: json['subscription'] != null
          ? Subscription.fromJson(json['subscription'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'subscription': subscription?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, subscription];
}

class Subscription extends Equatable {
  final int? id;
  final Plans? plan;
  final String? startDate;
  final String? endDate;
  final bool? isActive;

  const Subscription({
    this.id,
    this.plan,
    this.startDate,
    this.endDate,
    this.isActive,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      plan: json['plan'] != null ? Plans.fromJson(json['plan']) : null,
      startDate: json['start_date'],
      endDate: json['end_date'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan?.toJson(),
      'start_date': startDate,
      'end_date': endDate,
      'is_active': isActive,
    };
  }

  @override
  List<Object?> get props => [id, plan, startDate, endDate, isActive];
}
