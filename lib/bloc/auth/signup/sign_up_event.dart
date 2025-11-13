part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class EmailChangeEvent extends SignUpEvent {
  final String email;
  const EmailChangeEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class MobileChangeEvent extends SignUpEvent {
  final String mobile;
  const MobileChangeEvent({required this.mobile});
  @override
  List<Object?> get props => [mobile];
}

class ProfileCreatedForChangeEvent extends SignUpEvent {
  final String profileCreatedFor;
  const ProfileCreatedForChangeEvent({required this.profileCreatedFor});
  @override
  List<Object?> get props => [profileCreatedFor];
}

class GenderChangeEvent extends SignUpEvent {
  final String gender;
  const GenderChangeEvent({required this.gender});
  @override
  List<Object?> get props => [gender];
}

class FirstNameChangeEvent extends SignUpEvent {
  final String firstName;
  const FirstNameChangeEvent({required this.firstName});
  @override
  List<Object?> get props => [firstName];
}

class LastNameChangeEvent extends SignUpEvent {
  final String lastName;
  const LastNameChangeEvent({required this.lastName});
  @override
  List<Object?> get props => [lastName];
}

class DateOfBirthChangeEvent extends SignUpEvent {
  final String dateOfBirth;
  const DateOfBirthChangeEvent({required this.dateOfBirth});
  @override
  List<Object?> get props => [dateOfBirth];
}

class ReligionChangeEvent extends SignUpEvent {
  final String religion;
  const ReligionChangeEvent({required this.religion});
  @override
  List<Object?> get props => [religion];
}

class CommunityChangeEvent extends SignUpEvent {
  final String community;
  const CommunityChangeEvent({required this.community});
  @override
  List<Object?> get props => [community];
}

class CountryChangeEvent extends SignUpEvent {
  final String country;
  const CountryChangeEvent({required this.country});
  @override
  List<Object?> get props => [country];
}

class StateRegionChangeEvent extends SignUpEvent {
  final String stateRegion;
  const StateRegionChangeEvent({required this.stateRegion});
  @override
  List<Object?> get props => [stateRegion];
}

class CityChangeEvent extends SignUpEvent {
  final String city;
  const CityChangeEvent({required this.city});
  @override
  List<Object?> get props => [city];
}

class FatherNameChangeEvent extends SignUpEvent {
  final String fatherName;
  const FatherNameChangeEvent({required this.fatherName});
  @override
  List<Object?> get props => [fatherName];
}

class MotherNameChangeEvent extends SignUpEvent {
  final String motherName;
  const MotherNameChangeEvent({required this.motherName});
  @override
  List<Object?> get props => [motherName];
}

class NumberOfSisterChangeEvent extends SignUpEvent {
  final int numberOfSister;
  const NumberOfSisterChangeEvent({required this.numberOfSister});
  @override
  List<Object?> get props => [numberOfSister];
}

class NumberOfBrotherChangeEvent extends SignUpEvent {
  final int numberOfBrother;
  const NumberOfBrotherChangeEvent({required this.numberOfBrother});
  @override
  List<Object?> get props => [numberOfBrother];
}

class HeightChangeEvent extends SignUpEvent {
  final String height;
  const HeightChangeEvent({required this.height});
  @override
  List<Object?> get props => [height];
}

class DietChangeEvent extends SignUpEvent {
  final String diet;
  const DietChangeEvent({required this.diet});
  @override
  List<Object?> get props => [diet];
}

class HobbiesChangeEvent extends SignUpEvent {
  final List<String> hobbies;
  const HobbiesChangeEvent({required this.hobbies});
  @override
  List<Object?> get props => [hobbies];
}

class QualificationChangeEvent extends SignUpEvent {
  final String qualification;
  const QualificationChangeEvent({required this.qualification});
  @override
  List<Object?> get props => [qualification];
}

class FieldOfStudyChangeEvent extends SignUpEvent {
  final String fieldOfStudy;
  const FieldOfStudyChangeEvent({required this.fieldOfStudy});
  @override
  List<Object?> get props => [fieldOfStudy];
}

class UniversityChangeEvent extends SignUpEvent {
  final String university;
  const UniversityChangeEvent({required this.university});
  @override
  List<Object?> get props => [university];
}

class PassingYearChangeEvent extends SignUpEvent {
  final int passingYear;
  const PassingYearChangeEvent({required this.passingYear});
  @override
  List<Object?> get props => [passingYear];
}

class MonthlyIncomeChangeEvent extends SignUpEvent {
  final String monthlyIncome;
  const MonthlyIncomeChangeEvent({required this.monthlyIncome});
  @override
  List<Object?> get props => [monthlyIncome];
}

class JobChangeEvent extends SignUpEvent {
  final String job;
  const JobChangeEvent({required this.job});
  @override
  List<Object?> get props => [job];
}

class WorkLocationChangeEvent extends SignUpEvent {
  final String workLocation;
  const WorkLocationChangeEvent({required this.workLocation});
  @override
  List<Object?> get props => [workLocation];
}

class JobTypeChangeEvent extends SignUpEvent {
  final String jobType;
  const JobTypeChangeEvent({required this.jobType});
  @override
  List<Object?> get props => [jobType];
}

class MaritalStatusChangeEvent extends SignUpEvent {
  final String maritalStatus;
  const MaritalStatusChangeEvent({required this.maritalStatus});
  @override
  List<Object?> get props => [maritalStatus];
}

class ChildrenChangeEvent extends SignUpEvent {
  final String children;
  const ChildrenChangeEvent({required this.children});
  @override
  List<Object?> get props => [children];
}

class PasswordChangeEvent extends SignUpEvent {
  final String password;
  const PasswordChangeEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

/// Submit Button
class SubmitSignUpEvent extends SignUpEvent {
  const SubmitSignUpEvent();
}
