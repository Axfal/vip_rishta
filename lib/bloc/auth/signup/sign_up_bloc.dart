// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthApiRepo authApiRepo;

  SignUpBloc({required this.authApiRepo}) : super(const SignUpState()) {
    on<EmailChangeEvent>(_onEmailChange);
    on<MobileChangeEvent>(_onMobileChange);
    on<ProfileCreatedForChangeEvent>(_onProfileCreatedForChange);
    on<GenderChangeEvent>(_onGenderChange);
    on<FirstNameChangeEvent>(_onFirstNameChange);
    on<LastNameChangeEvent>(_onLastNameChange);
    on<DateOfBirthChangeEvent>(_onDateOfBirthChange);
    on<ReligionChangeEvent>(_onReligionChange);
    on<CommunityChangeEvent>(_onCommunityChange);
    on<CountryChangeEvent>(_onCountryChange);
    on<StateRegionChangeEvent>(_onStateRegionChange);
    on<CityChangeEvent>(_onCityChange);
    on<FatherNameChangeEvent>(_onFatherNameChange);
    on<MotherNameChangeEvent>(_onMotherNameChange);
    on<NumberOfSisterChangeEvent>(_onNumberOfSisterChange);
    on<NumberOfBrotherChangeEvent>(_onNumberOfBrotherChange);
    on<HeightChangeEvent>(_onHeightChange);
    on<DietChangeEvent>(_onDietChange);
    on<HobbiesChangeEvent>(_onHobbiesChange);
    on<QualificationChangeEvent>(_onQualificationChange);
    on<FieldOfStudyChangeEvent>(_onFieldOfStudyChange);
    on<UniversityChangeEvent>(_onUniversityChange);
    on<PassingYearChangeEvent>(_onPassingYearChange);
    on<MonthlyIncomeChangeEvent>(_onMonthlyIncomeChange);
    on<JobChangeEvent>(_onJobChange);
    on<WorkLocationChangeEvent>(_onWorkLocationChange);
    on<JobTypeChangeEvent>(_onJobTypeChange);
    on<MaritalStatusChangeEvent>(_onMaritalStatusChange);
    on<ChildrenChangeEvent>(_onChildrenChange);
    on<PasswordChangeEvent>(_onPasswordChange);
    on<SubmitSignUpEvent>(_onSubmitSignUp);
  }

  void _onEmailChange(EmailChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(email: event.email));

  void _onMobileChange(MobileChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(mobile: event.mobile));

  void _onProfileCreatedForChange(
    ProfileCreatedForChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(profileCreatedFor: event.profileCreatedFor));

  void _onGenderChange(GenderChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(gender: event.gender));

  void _onFirstNameChange(
    FirstNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(firstName: event.firstName));

  void _onLastNameChange(
    LastNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(lastName: event.lastName));

  void _onDateOfBirthChange(
    DateOfBirthChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(dateOfBirth: event.dateOfBirth));

  void _onReligionChange(
    ReligionChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(religion: event.religion));

  void _onCommunityChange(
    CommunityChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(community: event.community));

  void _onCountryChange(CountryChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(country: event.country));

  void _onStateRegionChange(
    StateRegionChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(stateRegion: event.stateRegion));

  void _onCityChange(CityChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(city: event.city));

  void _onFatherNameChange(
    FatherNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(fatherName: event.fatherName));

  void _onMotherNameChange(
    MotherNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(motherName: event.motherName));

  void _onNumberOfSisterChange(
    NumberOfSisterChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(numberOfSister: event.numberOfSister));

  void _onNumberOfBrotherChange(
    NumberOfBrotherChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(numberOfBrother: event.numberOfBrother));

  void _onHeightChange(HeightChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(height: event.height));

  void _onDietChange(DietChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(diet: event.diet));

  void _onHobbiesChange(HobbiesChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(hobbies: event.hobbies));

  void _onQualificationChange(
    QualificationChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(qualification: event.qualification));

  void _onFieldOfStudyChange(
    FieldOfStudyChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(fieldOfStudy: event.fieldOfStudy));

  void _onUniversityChange(
    UniversityChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(university: event.university));

  void _onPassingYearChange(
    PassingYearChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(passingYear: event.passingYear));

  void _onMonthlyIncomeChange(
    MonthlyIncomeChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(monthlyIncome: event.monthlyIncome));

  void _onJobChange(JobChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(job: event.job));

  void _onWorkLocationChange(
    WorkLocationChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(workLocation: event.workLocation));

  void _onJobTypeChange(JobTypeChangeEvent event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(jobType: event.jobType));

  void _onMaritalStatusChange(
    MaritalStatusChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(maritalStatus: event.maritalStatus));

  void _onChildrenChange(
    ChildrenChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(children: event.children));

  void _onPasswordChange(
    PasswordChangeEvent event,
    Emitter<SignUpState> emit,
  ) => emit(state.copyWith(password: event.password));

  /// Submit Form
  Future<void> _onSubmitSignUp(
    SubmitSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      final data = {
        "email": state.email,
        "mobile": state.mobile,
        "profile_created_for": state.profileCreatedFor,
        "gender": state.gender,
        "first_name": state.firstName,
        "last_name": state.lastName,
        "date_of_birth": state.dateOfBirth,
        "religion": state.religion,
        "community": state.community,
        "country": state.country,
        "state": state.stateRegion,
        "city": state.city,
        "father_name": state.fatherName,
        "mother_name": state.motherName,
        "number_of_sister": state.numberOfSister,
        "number_of_brother": state.numberOfBrother,
        "height": state.height,
        "diet": state.diet,
        "hobbies": state.hobbies.join(', '),
        "qualification": state.qualification,
        "field_of_study": state.fieldOfStudy,
        "university": state.university,
        "passing_year": state.passingYear,
        "monthly_income": state.monthlyIncome,
        "job": state.job,
        "work_location": state.workLocation,
        "job_type": state.jobType,
        "marital_status": state.maritalStatus,
        "children": state.children,
        "password": state.password,
      };

      final response = await authApiRepo.signup(data);

      if (response == null || response['success'] != true) {
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error(
              response?['message'] ?? "Signup failed",
            ),
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          apiResponse: ApiResponse.completed(
            response['message'] ?? "Signup Successful",
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error("Something went wrong: $e"),
        ),
      );
    }
  }
}
