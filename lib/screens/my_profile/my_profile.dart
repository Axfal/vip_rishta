import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/repo/profile/profille_api_repo.dart';
import 'package:rishta_app/dependency_indjection/locator.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../data/response/status.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late final ProfileBloc profileBloc;
  final _formKey = GlobalKey<FormState>();

  // controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final religionController = TextEditingController();
  final communityController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final heightController = TextEditingController();
  final dietController = TextEditingController();
  final hobbiesController = TextEditingController();
  final qualificationController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final universityController = TextEditingController();
  final passingYearController = TextEditingController();
  final jobController = TextEditingController();
  final workLocationController = TextEditingController();
  final jobTypeController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final numberOfChildrenController = TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // pick image from gallery
  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  // options
  final List<String> maritalStatusOptions = [
    "Never Married",
    "Divorced",
    "Widowed",
    "Awaiting Divorce",
    "Annulled",
  ];
  final List<String> numberOfChildrenOptions = ["0", "1", "2", "3", "4+"];
  final List<String> heightOptions = [
    "5'0\"",
    "5'1\"",
    "5'2\"",
    "5'3\"",
    "5'4\"",
    "5'5\"",
    "5'6\"",
    "5'7\"",
    "5'8\"",
    "5'9\"",
    "5'10\"",
    "5'11\"",
    "6'0\"",
    "6'1\"",
    "6'2\"",
    "6'3\"",
    "6'4\"",
    "6'5\"",
  ];
  final List<String> dietOptions = ["Vegetarian", "Non-Vegetarian"];
  final List<String> hobbyOptions = [
    "Reading",
    "Traveling",
    "Sports",
    "Music",
    "Cooking",
    "Photography",
    "Gaming",
    "Painting",
    "Dancing",
  ];
  List<String> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc(profileApiRepo: getIt<ProfileApiRepo>());
    profileBloc.add(GetProfileEvent());
  }

  @override
  void dispose() {
    profileBloc.close();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    dobController.dispose();
    religionController.dispose();
    communityController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    heightController.dispose();
    dietController.dispose();
    hobbiesController.dispose();
    qualificationController.dispose();
    fieldOfStudyController.dispose();
    universityController.dispose();
    passingYearController.dispose();
    jobController.dispose();
    workLocationController.dispose();
    jobTypeController.dispose();
    maritalStatusController.dispose();
    numberOfChildrenController.dispose();
    super.dispose();
  }

  void _fillControllersFromModel() {
    final user = profileBloc.state.userProfileModel.user;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    genderController.text = user.gender;
    dobController.text = user.dateOfBirth;
    religionController.text = user.religion;
    communityController.text = user.community;
    countryController.text = user.country;
    stateController.text = user.state;
    cityController.text = user.city;
    heightController.text = user.height;
    dietController.text = user.diet;
    hobbiesController.text = user.hobbies;
    qualificationController.text = user.qualification;
    fieldOfStudyController.text = user.fieldOfStudy;
    universityController.text = user.university;
    passingYearController.text = user.passingYear.toString();
    jobController.text = user.job;
    workLocationController.text = user.workLocation;
    jobTypeController.text = user.jobType;
    maritalStatusController.text = user.maritalStatus;
    numberOfChildrenController.text = user.children;

    if (user.hobbies.isNotEmpty) {
      selectedHobbies = user.hobbies
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
  }

  // generic bottom sheet picker for single selection
  void _openSinglePicker({
    required List<String> options,
    required TextEditingController controller,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.Linear_gradient,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, idx) {
                      final option = options[idx];
                      return InkWell(
                        onTap: () {
                          controller.text = option;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Text(
                            option,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // multiple selection for hobbies
  void _openHobbiesPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModal) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.Linear_gradient,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Text(
                      "Select Hobbies",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: hobbyOptions.map((hobby) {
                          final selected = selectedHobbies.contains(hobby);
                          return CheckboxListTile(
                            title: Text(
                              hobby,
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            value: selected,
                            activeColor: AppColors.primaryColor,
                            onChanged: (val) {
                              setModal(() {
                                if (val == true) {
                                  if (!selectedHobbies.contains(hobby)) {
                                    selectedHobbies.add(hobby);
                                  }
                                } else {
                                  selectedHobbies.remove(hobby);
                                }
                                hobbiesController.text = selectedHobbies.join(
                                  ", ",
                                );
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onSavePressed() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    profileBloc.add(
      UpdateProfileEvent(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: genderController.text,
        dateOfBirth: dobController.text,
        religion: religionController.text,
        community: communityController.text,
        country: countryController.text,
        state: stateController.text,
        city: cityController.text,
        height: heightController.text,
        diet: dietController.text,
        hobbies: hobbiesController.text,
        qualification: qualificationController.text,
        fieldOfStudy: fieldOfStudyController.text,
        university: universityController.text,
        passingYear: passingYearController.text,
        job: jobController.text,
        workLocation: workLocationController.text,
        jobType: jobTypeController.text,
        maritalStatus: maritalStatusController.text,
        children: numberOfChildrenController.text,
        image: _pickedImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Profile",
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.apiResponse.status == Status.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.apiResponse.message ?? 'Error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              _fillControllersFromModel();
            },
            builder: (context, state) {
              if (state.apiResponse.status == Status.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(color: Colors.black26),
                );
              }

              if (state.apiResponse.status == Status.error) {
                return Center(
                  child: Text(
                    state.apiResponse.message ?? "Failed to load profile",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              final user = state.userProfileModel.user;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// Profile Image
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.white24,
                            child: ClipOval(
                              child: _pickedImage != null
                                  ? Image.file(
                                      _pickedImage!,
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    )
                                  : (user.image.isNotEmpty
                                        ? Image.network(
                                            APIUrls.baseUrl + user.image,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                            errorBuilder: (c, e, st) =>
                                                const Icon(
                                                  Icons.person,
                                                  size: 60,
                                                  color: Colors.white70,
                                                ),
                                          )
                                        : Image.asset(
                                            'assets/logo/vip_rishta.png',
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                            errorBuilder: (c, e, st) =>
                                                const Icon(
                                                  Icons.person,
                                                  size: 60,
                                                  color: Colors.white70,
                                                ),
                                          )),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            right: 15,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black87.withValues(
                                      alpha: .77,
                                    ),
                                  ),
                                  color: AppColors.white,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.edit,
                                  size: 22,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// Name
                      Text(
                        "${firstNameController.text} ${lastNameController.text}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 30),

                      /// Fields
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: firstNameController,
                        hintText: "First Name",
                        validator: (v) =>
                            v == null || v.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: lastNameController,
                        hintText: "Last Name",
                        validator: (v) =>
                            v == null || v.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: genderController,
                        hintText: "Gender",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: dobController,
                        hintText: "Date of Birth",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: religionController,
                        hintText: "Religion",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: communityController,
                        hintText: "Community",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: countryController,
                        hintText: "Country",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: stateController,
                        hintText: "State",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: cityController,
                        hintText: "City",
                      ),
                      const SizedBox(height: 10),

                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: heightController,
                        hintText: "Select Height",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: heightOptions,
                          controller: heightController,
                          title: "Select Height",
                        ),
                      ),
                      const SizedBox(height: 18),

                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: dietController,
                        hintText: "Select Diet",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: dietOptions,
                          controller: dietController,
                          title: "Select Diet",
                        ),
                      ),
                      const SizedBox(height: 18),

                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: hobbiesController,
                        hintText: "Select Hobbies",
                        isDropdown: true,
                        onTap: _openHobbiesPicker,
                      ),
                      const SizedBox(height: 10),

                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: qualificationController,
                        hintText: "Qualification",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: fieldOfStudyController,
                        hintText: "Field of Study",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: universityController,
                        hintText: "University",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: passingYearController,
                        hintText: "Passing Year",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: jobController,
                        hintText: "Job",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: workLocationController,
                        hintText: "Work Location",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: [
                            'Office',
                            'Home',
                            'School',
                            'Hospital',
                            'Factory',
                            'Other',
                          ],
                          controller: workLocationController,
                          title: "Select Work Location",
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: jobTypeController,
                        hintText: "Job Type",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: [
                            'Government',
                            'Private',
                            'Self-employed',
                            'Freelancer',
                            'Unemployed',
                          ],
                          controller: jobTypeController,
                          title: "Select Job Type",
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: maritalStatusController,
                        hintText: "Select Marital Status",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: maritalStatusOptions,
                          controller: maritalStatusController,
                          title: "Marital Status",
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: Colors.black54,
                        controller: numberOfChildrenController,
                        hintText: "Select number of children",
                        isDropdown: true,
                        onTap: () => _openSinglePicker(
                          options: numberOfChildrenOptions,
                          controller: numberOfChildrenController,
                          title: "Number of Children",
                        ),
                      ),
                      const SizedBox(height: 30),

                      SafeArea(
                        child: GestureDetector(
                          onTap: _onSavePressed,
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.95,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: state.apiResponse.status == Status.loading
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Save",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
