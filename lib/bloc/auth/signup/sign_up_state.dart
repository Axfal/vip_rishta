part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String email;
  final String mobile;
  final String profileCreatedFor;
  final String gender;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String religion;
  final String community;
  final String country;
  final String stateRegion;
  final String city;
  final String fatherName;
  final String motherName;
  final int numberOfSister;
  final int numberOfBrother;
  final String height;
  final String diet;
  final List<String> hobbies;
  final String qualification;
  final String fieldOfStudy;
  final String university;
  final int passingYear;
  final String monthlyIncome;
  final String job;
  final String workLocation;
  final String jobType;
  final String maritalStatus;
  final String children;
  final String password;
  final ApiResponse<String> apiResponse;

  const SignUpState({
    this.email = '',
    this.mobile = '',
    this.profileCreatedFor = '',
    this.gender = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth = '',
    this.religion = '',
    this.community = '',
    this.country = '',
    this.stateRegion = '',
    this.city = '',
    this.fatherName = '',
    this.motherName = '',
    this.numberOfSister = 0,
    this.numberOfBrother = 0,
    this.height = '',
    this.diet = '',
    this.hobbies = const [],
    this.qualification = '',
    this.fieldOfStudy = '',
    this.university = '',
    this.passingYear = 0,
    this.monthlyIncome = '',
    this.job = '',
    this.workLocation = '',
    this.jobType = '',
    this.maritalStatus = '',
    this.children = '',
    this.password = '',
    this.apiResponse = const ApiResponse.completed(''),
  });

  SignUpState copyWith({
    String? email,
    String? mobile,
    String? profileCreatedFor,
    String? gender,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? religion,
    String? community,
    String? country,
    String? stateRegion,
    String? city,
    String? fatherName,
    String? motherName,
    int? numberOfSister,
    int? numberOfBrother,
    String? height,
    String? diet,
    List<String>? hobbies,
    String? qualification,
    String? fieldOfStudy,
    String? university,
    int? passingYear,
    String? monthlyIncome,
    String? job,
    String? workLocation,
    String? jobType,
    String? maritalStatus,
    String? children,
    String? password,
    ApiResponse<String>? apiResponse,
  }) {
    return SignUpState(
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      profileCreatedFor: profileCreatedFor ?? this.profileCreatedFor,
      gender: gender ?? this.gender,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      religion: religion ?? this.religion,
      community: community ?? this.community,
      country: country ?? this.country,
      stateRegion: stateRegion ?? this.stateRegion,
      city: city ?? this.city,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      numberOfSister: numberOfSister ?? this.numberOfSister,
      numberOfBrother: numberOfBrother ?? this.numberOfBrother,
      height: height ?? this.height,
      diet: diet ?? this.diet,
      hobbies: hobbies ?? this.hobbies,
      qualification: qualification ?? this.qualification,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      university: university ?? this.university,
      passingYear: passingYear ?? this.passingYear,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      job: job ?? this.job,
      workLocation: workLocation ?? this.workLocation,
      jobType: jobType ?? this.jobType,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      children: children ?? this.children,
      password: password ?? this.password,
      apiResponse: apiResponse ?? this.apiResponse,
    );
  }

  @override
  List<Object?> get props => [
    email,
    mobile,
    profileCreatedFor,
    gender,
    firstName,
    lastName,
    dateOfBirth,
    religion,
    community,
    country,
    stateRegion,
    city,
    fatherName,
    motherName,
    numberOfSister,
    numberOfBrother,
    height,
    diet,
    hobbies,
    qualification,
    fieldOfStudy,
    university,
    passingYear,
    monthlyIncome,
    job,
    workLocation,
    jobType,
    maritalStatus,
    children,
    password,
    apiResponse,
  ];
}
