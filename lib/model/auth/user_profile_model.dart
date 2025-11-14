class UserProfileModel {
  final bool success;
  final User user;

  const UserProfileModel({this.success = false, this.user = const User()});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'] ?? false,
      user: json['user'] != null ? User.fromJson(json['user']) : const User(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'user': user.toJson()};
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final int age;
  final String religion;
  final String community;
  final String country;
  final String state;
  final String city;
  final String height;
  final String diet;
  final String hobbies;
  final String qualification;
  final String fieldOfStudy;
  final String university;
  final int passingYear;
  final String job;
  final String workLocation;
  final String jobType;
  final String maritalStatus;
  final String children;
  final String image;
  final bool isOnline;
  final bool isPremium;

  const User({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.dateOfBirth = '',
    this.age = 0,
    this.religion = '',
    this.community = '',
    this.country = '',
    this.state = '',
    this.city = '',
    this.height = '',
    this.diet = '',
    this.hobbies = '',
    this.qualification = '',
    this.fieldOfStudy = '',
    this.university = '',
    this.passingYear = 0,
    this.job = '',
    this.workLocation = '',
    this.jobType = '',
    this.maritalStatus = '',
    this.children = '',
    this.image = '',
    this.isOnline = false,
    this.isPremium = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      age: json['age'] ?? 0,
      religion: json['religion'] ?? '',
      community: json['community'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      height: json['height'] ?? '',
      diet: json['diet'] ?? '',
      hobbies: json['hobbies'] ?? '',
      qualification: json['qualification'] ?? '',
      fieldOfStudy: json['field_of_study'] ?? '',
      university: json['university'] ?? '',
      passingYear: json['passing_year'] ?? 0,
      job: json['job'] ?? '',
      workLocation: json['work_location'] ?? '',
      jobType: json['job_type'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      children: json['children'] ?? '',
      image: json['image'] ?? '',
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
