class MatchModel {
  final bool? success;
  final List<MatchResult> results;

  const MatchModel({
    this.success,
    this.results = const [], // Required for const MatchModel()
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      success: json['success'],
      results: json['results'] != null
          ? List<MatchResult>.from(
        json['results'].map((x) => MatchResult.fromJson(x)),
      )
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class MatchResult {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? dateOfBirth;
  final int? age;
  final String? religion;
  final String? community;
  final String? country;
  final String? state;
  final String? city;
  final String? height;
  final String? diet;
  final String? hobbies;
  final String? qualification;
  final String? fieldOfStudy;
  final String? university;
  final int? passingYear;
  final String? job;
  final String? workLocation;
  final String? jobType;
  final String? maritalStatus;
  final String? children;
  final String? image;
  final bool? isOnline;
  final bool? isPremium;

  const MatchResult({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.age,
    this.religion,
    this.community,
    this.country,
    this.state,
    this.city,
    this.height,
    this.diet,
    this.hobbies,
    this.qualification,
    this.fieldOfStudy,
    this.university,
    this.passingYear,
    this.job,
    this.workLocation,
    this.jobType,
    this.maritalStatus,
    this.children,
    this.image,
    this.isOnline,
    this.isPremium,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) {
    return MatchResult(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      age: json['age'],
      religion: json['religion'],
      community: json['community'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      height: json['height'],
      diet: json['diet'],
      hobbies: json['hobbies'],
      qualification: json['qualification'],
      fieldOfStudy: json['field_of_study'],
      university: json['university'],
      passingYear: json['passing_year'],
      job: json['job'],
      workLocation: json['work_location'],
      jobType: json['job_type'],
      maritalStatus: json['marital_status'],
      children: json['children'],
      image: json['image'],
      isOnline: json['is_online'],
      isPremium: json['is_premium'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'age': age,
      'religion': religion,
      'community': community,
      'country': country,
      'state': state,
      'city': city,
      'height': height,
      'diet': diet,
      'hobbies': hobbies,
      'qualification': qualification,
      'field_of_study': fieldOfStudy,
      'university': university,
      'passing_year': passingYear,
      'job': job,
      'work_location': workLocation,
      'job_type': jobType,
      'marital_status': maritalStatus,
      'children': children,
      'image': image,
      'is_online': isOnline,
      'is_premium': isPremium,
    };
  }
}
