import 'package:equatable/equatable.dart';

class PremiumPlanModel extends Equatable {
  final bool? success;
  final List<Plans>? plans;

  const PremiumPlanModel({
    this.success,
    this.plans,
  });

  factory PremiumPlanModel.fromJson(Map<String, dynamic> json) {
    return PremiumPlanModel(
      success: json['success'],
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plans.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'plans': plans?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [success, plans];
}

class Plans extends Equatable {
  final int? id;
  final String? name;
  final String? price;
  final int? duration;
  final String? durationType;
  final String? description;
  final bool? isActive;
  final bool? canViewProfileViews;
  final bool? canSendContactRequest;
  final bool? canChatUnlimited;
  final bool? canUseIncognito;
  final bool? canGetVerifiedBadge;
  final bool? canProfileBoost;

  const Plans({
    this.id,
    this.name,
    this.price,
    this.duration,
    this.durationType,
    this.description,
    this.isActive,
    this.canViewProfileViews,
    this.canSendContactRequest,
    this.canChatUnlimited,
    this.canUseIncognito,
    this.canGetVerifiedBadge,
    this.canProfileBoost,
  });

  factory Plans.fromJson(Map<String, dynamic> json) {
    return Plans(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      duration: json['duration'],
      durationType: json['duration_type'],
      description: json['description'],
      isActive: json['is_active'],
      canViewProfileViews: json['can_view_profile_views'],
      canSendContactRequest: json['can_send_contact_request'],
      canChatUnlimited: json['can_chat_unlimited'],
      canUseIncognito: json['can_use_incognito'],
      canGetVerifiedBadge: json['can_get_verified_badge'],
      canProfileBoost: json['can_profile_boost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'duration': duration,
      'duration_type': durationType,
      'description': description,
      'is_active': isActive,
      'can_view_profile_views': canViewProfileViews,
      'can_send_contact_request': canSendContactRequest,
      'can_chat_unlimited': canChatUnlimited,
      'can_use_incognito': canUseIncognito,
      'can_get_verified_badge': canGetVerifiedBadge,
      'can_profile_boost': canProfileBoost,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    duration,
    durationType,
    description,
    isActive,
    canViewProfileViews,
    canSendContactRequest,
    canChatUnlimited,
    canUseIncognito,
    canGetVerifiedBadge,
    canProfileBoost,
  ];
}
