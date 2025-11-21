class PartnerPreferenceModel {
  final int minAge;
  final int maxAge;
  final String preferredCity;
  final String preferredReligion;
  final String preferredEducation;
  final String preferredJob;
  final String preferredMaritalStatus;

  const PartnerPreferenceModel({
    this.minAge = 18,
    this.maxAge = 40,
    this.preferredCity = "",
    this.preferredReligion = "",
    this.preferredEducation = "",
    this.preferredJob = "",
    this.preferredMaritalStatus = "",
  });

  factory PartnerPreferenceModel.fromJson(Map<String, dynamic> json) {
    return PartnerPreferenceModel(
      minAge: json['min_age'] ?? 18,
      maxAge: json['max_age'] ?? 40,
      preferredCity: json['preferred_city'] ?? "",
      preferredReligion: json['preferred_religion'] ?? "",
      preferredEducation: json['preferred_education'] ?? "",
      preferredJob: json['preferred_job'] ?? "",
      preferredMaritalStatus: json['preferred_marital_status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "min_age": minAge,
      "max_age": maxAge,
      "preferred_city": preferredCity,
      "preferred_religion": preferredReligion,
      "preferred_education": preferredEducation,
      "preferred_job": preferredJob,
      "preferred_marital_status": preferredMaritalStatus,
    };
  }

  PartnerPreferenceModel copyWith({
    int? minAge,
    int? maxAge,
    String? preferredCity,
    String? preferredReligion,
    String? preferredEducation,
    String? preferredJob,
    String? preferredMaritalStatus,
  }) {
    return PartnerPreferenceModel(
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      preferredCity: preferredCity ?? this.preferredCity,
      preferredReligion: preferredReligion ?? this.preferredReligion,
      preferredEducation: preferredEducation ?? this.preferredEducation,
      preferredJob: preferredJob ?? this.preferredJob,
      preferredMaritalStatus:
      preferredMaritalStatus ?? this.preferredMaritalStatus,
    );
  }
}
