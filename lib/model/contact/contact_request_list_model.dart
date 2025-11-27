class ContactRequestedListModel {
  final bool success;
  final int count;
  final List<String> requestedUserIds;

  const ContactRequestedListModel({
    this.success = false,
    this.count = 0,
    this.requestedUserIds = const [],
  });

  factory ContactRequestedListModel.fromJson(Map<String, dynamic> json) {
    return ContactRequestedListModel(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      requestedUserIds:
          (json['requested_user_ids'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'requested_user_ids': requestedUserIds,
    };
  }
}
