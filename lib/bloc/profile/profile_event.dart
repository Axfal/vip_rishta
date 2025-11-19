part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
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
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
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
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    gender,
    dateOfBirth,
    religion,
    community,
    country,
    state,
    city,
    height,
    diet,
    hobbies,
    qualification,
    fieldOfStudy,
    university,
    passingYear,
    job,
    workLocation,
    jobType,
    maritalStatus,
    children,
    image,
  ];
}
