class UserModel {
  final bool? success;
  final String? message;
  final Tokens? tokens;
  final User? user;

  const UserModel({
    this.success,
    this.message,
    this.tokens,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'],
      message: json['message'],
      tokens: json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'tokens': tokens?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class Tokens {
  final String? refresh;
  final String? access;

  const Tokens({this.refresh, this.access});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
      'access': access,
    };
  }
}

class User {
  final String? id;
  final String? password;
  final String? lastLogin;
  final bool? isSuperuser;
  final String? email;
  final String? mobile;
  final String? profileCreatedFor;
  final String? gender;
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? religion;
  final String? community;
  final String? country;
  final String? state;
  final String? city;
  final String? fatherName;
  final String? motherName;
  final int? numberOfSister;
  final int? numberOfBrother;
  final String? height;
  final String? diet;
  final String? hobbies;
  final String? qualification;
  final String? fieldOfStudy;
  final String? university;
  final int? passingYear;
  final String? monthlyIncome;
  final String? job;
  final String? workLocation;
  final String? jobType;
  final String? maritalStatus;
  final String? children;
  final bool? isActive;
  final bool? isStaff;
  final bool? emailVerified;
  final bool? mobileVerified;
  final bool? isPremium;
  final String? premiumStart;
  final String? premiumEnd;
  final bool? isBoosted;
  final String? boostExpiry;
  final bool? isIncognito;
  final String? dateJoined;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;

  const User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.email,
    this.mobile,
    this.profileCreatedFor,
    this.gender,
    this.image,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.religion,
    this.community,
    this.country,
    this.state,
    this.city,
    this.fatherName,
    this.motherName,
    this.numberOfSister,
    this.numberOfBrother,
    this.height,
    this.diet,
    this.hobbies,
    this.qualification,
    this.fieldOfStudy,
    this.university,
    this.passingYear,
    this.monthlyIncome,
    this.job,
    this.workLocation,
    this.jobType,
    this.maritalStatus,
    this.children,
    this.isActive,
    this.isStaff,
    this.emailVerified,
    this.mobileVerified,
    this.isPremium,
    this.premiumStart,
    this.premiumEnd,
    this.isBoosted,
    this.boostExpiry,
    this.isIncognito,
    this.dateJoined,
    this.groups,
    this.userPermissions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      password: json['password'],
      lastLogin: json['last_login'],
      isSuperuser: json['is_superuser'],
      email: json['email'],
      mobile: json['mobile'],
      profileCreatedFor: json['profile_created_for'],
      gender: json['gender'],
      image: json['image'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      religion: json['religion'],
      community: json['community'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      numberOfSister: json['number_of_sister'],
      numberOfBrother: json['number_of_brother'],
      height: json['height'],
      diet: json['diet'],
      hobbies: json['hobbies'],
      qualification: json['qualification'],
      fieldOfStudy: json['field_of_study'],
      university: json['university'],
      passingYear: json['passing_year'],
      monthlyIncome: json['monthly_income'],
      job: json['job'],
      workLocation: json['work_location'],
      jobType: json['job_type'],
      maritalStatus: json['marital_status'],
      children: json['children'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      emailVerified: json['email_verified'],
      mobileVerified: json['mobile_verified'],
      isPremium: json['is_premium'],
      premiumStart: json['premium_start'],
      premiumEnd: json['premium_end'],
      isBoosted: json['is_boosted'],
      boostExpiry: json['boost_expiry'],
      isIncognito: json['is_incognito'],
      dateJoined: json['date_joined'],
      groups: json['groups'] ?? [],
      userPermissions: json['user_permissions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'last_login': lastLogin,
      'is_superuser': isSuperuser,
      'email': email,
      'mobile': mobile,
      'profile_created_for': profileCreatedFor,
      'gender': gender,
      'image': image,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'religion': religion,
      'community': community,
      'country': country,
      'state': state,
      'city': city,
      'father_name': fatherName,
      'mother_name': motherName,
      'number_of_sister': numberOfSister,
      'number_of_brother': numberOfBrother,
      'height': height,
      'diet': diet,
      'hobbies': hobbies,
      'qualification': qualification,
      'field_of_study': fieldOfStudy,
      'university': university,
      'passing_year': passingYear,
      'monthly_income': monthlyIncome,
      'job': job,
      'work_location': workLocation,
      'job_type': jobType,
      'marital_status': maritalStatus,
      'children': children,
      'is_active': isActive,
      'is_staff': isStaff,
      'email_verified': emailVerified,
      'mobile_verified': mobileVerified,
      'is_premium': isPremium,
      'premium_start': premiumStart,
      'premium_end': premiumEnd,
      'is_boosted': isBoosted,
      'boost_expiry': boostExpiry,
      'is_incognito': isIncognito,
      'date_joined': dateJoined,
      'groups': groups,
      'user_permissions': userPermissions,
    };
  }
}
