import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/work_detail.dart';

class Qualification extends StatefulWidget {
  const Qualification({super.key});

  @override
  State<Qualification> createState() => _QualificationState();
}

class _QualificationState extends State<Qualification> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _graduationYearController =
      TextEditingController();

  DateTime? _graduationYear;

  final List<String> qualificationOptions = [
    "Matric",
    "Intermediate",
    "Bachelor's",
    "Master's",
    "PhD",
    "Diploma",
    "MBBS",
    "CA",
    "LLB",
    "Other",
  ];

  void _openQualificationPicker() {
    final signUpBloc = context.read<SignUpBloc>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              gradient: AppColors.Linear_gradient,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Select Qualification",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: qualificationOptions.length,
                    itemBuilder: (context, index) {
                      final qualification = qualificationOptions[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _qualificationController.text = qualification;

                          // Update BLoC state
                          signUpBloc.add(
                            QualificationChangeEvent(
                              qualification: qualification,
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            qualification,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.w500),
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

  void _submitForm(SignUpBloc signupBloc) {
    if (_formKey.currentState!.validate()) {
      final yearText = _graduationYearController.text;
      final year = int.tryParse(yearText);

      if (year == null || year < 1950 || year > DateTime.now().year) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please enter a valid graduation year",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
        );
        return;
      }

      _graduationYear = DateTime(year);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: signupBloc, child: const WorkDetail()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all required fields correctly",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.Linear_gradient),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 120,
                left: 50,
                child:
                    Icon(
                          Icons.favorite,
                          size: 28,
                          color: AppColors.white.withValues(alpha: 0.2),
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .moveY(
                          begin: 0,
                          end: -20,
                          duration: 2500.ms,
                          curve: Curves.easeInOut,
                        ),
              ),
              Positioned(
                top: 200,
                right: 60,
                child:
                    Icon(
                          Icons.favorite,
                          size: 20,
                          color: AppColors.white.withValues(alpha: 0.15),
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .moveY(
                          begin: 0,
                          end: 15,
                          duration: 2200.ms,
                          curve: Curves.easeInOut,
                        ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo/vip_rishta.png', height: 100)
                          .animate()
                          .fade(duration: 900.ms)
                          .scale(duration: 1200.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      Text(
                            "Add Your Qualification",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          )
                          .animate()
                          .fade(duration: 800.ms)
                          .moveY(begin: 14, end: 0, curve: Curves.easeOut),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (current, previous) =>
                                  current.qualification !=
                                  previous.qualification,
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _qualificationController,
                                  hintText: "Select Qualification",
                                  labelText: "Qualification",
                                  isDropdown: true,
                                  onTap: _openQualificationPicker,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Qualification is required";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    signUpBloc.add(
                                      QualificationChangeEvent(
                                        qualification: value,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (current, previous) =>
                                  current.fieldOfStudy != previous.fieldOfStudy,
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _fieldOfStudyController,
                                  hintText: "Enter field of study",
                                  labelText: "Field of Study",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field of study is required";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    signUpBloc.add(
                                      FieldOfStudyChangeEvent(
                                        fieldOfStudy: value,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (current, previous) =>
                                  current.university != previous.university,
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _universityController,
                                  hintText: "Enter university/college",
                                  labelText: "University / College",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "University or college name is required";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    signUpBloc.add(
                                      UniversityChangeEvent(university: value),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (current, previous) =>
                                  current.passingYear != previous.passingYear,
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _graduationYearController,
                                  hintText:
                                      "Enter year of graduation (e.g. 2022)",
                                  labelText: "Graduation Year",
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Graduation year is required";
                                    }
                                    final year = int.tryParse(value);
                                    if (year == null ||
                                        year < 1950 ||
                                        year > DateTime.now().year) {
                                      return "Enter a valid year";
                                    }
                                    return null;
                                  },
                                  onChange: (value) {
                                    int? passingYear = int.tryParse(value);
                                    signUpBloc.add(
                                      PassingYearChangeEvent(
                                        passingYear: passingYear ?? 0,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CustomGradientButton(
                                text: "Continue",
                                textColor: AppColors.primaryColor,
                                backgroundColor: Colors.white,
                                onPressed: () => _submitForm(signUpBloc),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
