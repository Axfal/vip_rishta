class LikedProfileModel {
  final bool success;
  final int count;
  final List<String> userIds;

  const LikedProfileModel({
    this.success = false,
    this.count = 0,
    this.userIds = const [],
  });

  factory LikedProfileModel.fromJson(Map<String, dynamic> json) {
    return LikedProfileModel(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      userIds: json['user_ids'] != null
          ? List<String>.from(json['user_ids'])
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'user_ids': userIds,
    };
  }

  LikedProfileModel copyWith({
    bool? success,
    int? count,
    List<String>? userIds,
  }) {
    return LikedProfileModel(
      success: success ?? this.success,
      count: count ?? this.count,
      userIds: userIds ?? this.userIds,
    );
  }
}
