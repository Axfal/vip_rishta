class ReceivedContactRequestModel {
  final bool success;
  final List<Data> data;

  const ReceivedContactRequestModel({
    this.success = false,
    this.data = const [],
  });

  factory ReceivedContactRequestModel.fromJson(Map<String, dynamic> json) {
    return ReceivedContactRequestModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class Data {
  final int id;
  final Requester? requester;
  final Requested? requested;
  final bool approved;
  final String requestedAt;
  final String? approvedAt;

  const Data({
    this.id = 0,
    this.requester,
    this.requested,
    this.approved = false,
    this.requestedAt = '',
    this.approvedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      requester: json['requester'] != null
          ? Requester.fromJson(json['requester'])
          : null,
      requested: json['requested'] != null
          ? Requested.fromJson(json['requested'])
          : null,
      approved: json['approved'] ?? false,
      requestedAt: json['requested_at'] ?? '',
      approvedAt: json['approved_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requester': requester?.toJson(),
      'requested': requested?.toJson(),
      'approved': approved,
      'requested_at': requestedAt,
      'approved_at': approvedAt,
    };
  }
}

class Requester {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
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
  final bool isOnline;
  final bool isPremium;

  const Requester({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
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
    this.isOnline = false,
    this.isPremium = false,
  });

  factory Requester.fromJson(Map<String, dynamic> json) {
    return Requester(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? '',
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
      isOnline: json['is_online'] ?? false,
      isPremium: json['is_premium'] ?? false,
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

class Requested extends Requester {
  const Requested({
    super.id,
    super.firstName,
    super.lastName,
    super.gender,
    super.dateOfBirth,
    super.age,
    super.religion,
    super.community,
    super.country,
    super.state,
    super.city,
    super.height,
    super.diet,
    super.hobbies,
    super.qualification,
    super.fieldOfStudy,
    super.university,
    super.passingYear,
    super.job,
    super.workLocation,
    super.jobType,
    super.maritalStatus,
    super.children,
    super.image,
    super.isOnline,
    super.isPremium,
  });

  factory Requested.fromJson(Map<String, dynamic> json) {
    return Requested(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? '',
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
      isOnline: json['is_online'] ?? false,
      isPremium: json['is_premium'] ?? false,
    );
  }
}
