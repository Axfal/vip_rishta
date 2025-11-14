part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? dateOfBirth;
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
  final String? passingYear;
  final String? job;
  final String? workLocation;
  final String? jobType;
  final String? maritalStatus;
  final String? children;
  final File? image;

  const UpdateProfileEvent({
    this.children,
    this.maritalStatus,
    this.jobType,
    this.workLocation,
    this.job,
    this.passingYear,
    this.fieldOfStudy,
    this.qualification,
    this.hobbies,
    this.diet,
    this.height,
    this.country,
    this.community,
    this.religion,
    this.dateOfBirth,
    this.firstName,
    this.gender,
    this.state,
    this.image,
    this.city,
    this.lastName,
    this.university,
  });
  @override
  List<Object?> get props => [
    children,
    maritalStatus,
    jobType,
    workLocation,
    job,
    passingYear,
    fieldOfStudy,
    qualification,
    hobbies,
    diet,
    height,
    country,
    community,
    religion,
    dateOfBirth,
    firstName,
    gender,
    state,
    image,
    city,
    lastName,
    university,
  ];
}
