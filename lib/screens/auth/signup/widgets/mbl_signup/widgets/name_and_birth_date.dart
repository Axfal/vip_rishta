import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/global_widgets/auth/date_picker.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/users_detail_screen.dart';
import '../../../../../../bloc/auth/signup/sign_up_bloc.dart';

class NameAndBirthDate extends StatefulWidget {
  final String profileFor;
  final String? gender;

  const NameAndBirthDate({super.key, required this.profileFor, this.gender});

  @override
  State<NameAndBirthDate> createState() => _NameAndBirthDateState();
}

class _NameAndBirthDateState extends State<NameAndBirthDate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? selectedDate;

  String getTitleText() {
    if (widget.profileFor == "Myself") {
      return "Your Name";
    } else if (widget.gender == "Male") {
      return "His Name";
    } else if (widget.gender == "Female") {
      return "Her Name";
    } else {
      return "Name";
    }
  }

  int calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              right: 40,
              child:
                  Icon(
                        Icons.favorite,
                        size: 36,
                        color: AppColors.white.withValues(alpha: 0.25),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(begin: 0, end: -20, duration: 2200.ms),
            ),
            Positioned(
              bottom: 140,
              left: 50,
              child:
                  Icon(
                        Icons.favorite,
                        size: 28,
                        color: AppColors.white.withValues(alpha: 0.20),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(begin: 0, end: 20, duration: 2500.ms),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 120,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/logo/vip_rishta.png', height: 110)
                        .animate()
                        .fade(duration: 900.ms)
                        .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                    const SizedBox(height: 18),

                    Text(
                      getTitleText(),
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ).animate().fade(duration: 900.ms).moveY(begin: 14, end: 0),

                    const SizedBox(height: 30),

                    BlocBuilder<SignUpBloc, SignUpState>(
                          buildWhen: (current, previous) =>
                              current.firstName != previous.firstName,
                          builder: (context, state) {
                            return CustomTextField(
                              controller: _firstNameController,
                              hintText: "First name",
                              labelText: "First name",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? "First name is required"
                                  : null,
                              onChange: (value) {
                                signUpBloc.add(
                                  FirstNameChangeEvent(firstName: value),
                                );
                              },
                            );
                          },
                        )
                        .animate()
                        .fadeIn(duration: 1000.ms)
                        .moveX(begin: -30, end: 0),

                    const SizedBox(height: 18),

                    /// Last Name
                    BlocBuilder<SignUpBloc, SignUpState>(
                          buildWhen: (current, previous) =>
                              current.lastName != previous.lastName,
                          builder: (context, state) {
                            return CustomTextField(
                              controller: _lastNameController,
                              hintText: "Last name",
                              labelText: "Last name",
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? "Last name is required"
                                  : null,
                              onChange: (value) {
                                signUpBloc.add(
                                  LastNameChangeEvent(lastName: value),
                                );
                              },
                            );
                          },
                        )
                        .animate()
                        .fadeIn(duration: 1100.ms)
                        .moveX(begin: 30, end: 0),

                    const SizedBox(height: 25),

                    /// Date of Birth
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Date of birth",
                        style: AppText.subheading.copyWith(color: Colors.white),
                      ),
                    ),

                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (current, previous) =>
                          current.dateOfBirth != previous.dateOfBirth,
                      builder: (context, state) {
                        return CustomDatePickerField(
                          selectedDate: selectedDate,
                          onDateSelected: (date) {
                            setState(() => selectedDate = date);

                            final formattedDate =
                                "${selectedDate?.year.toString().padLeft(4, '0')}-"
                                "${selectedDate?.month.toString().padLeft(2, '0')}-"
                                "${selectedDate?.day.toString().padLeft(2, '0')}";

                            signUpBloc.add(
                              DateOfBirthChangeEvent(
                                dateOfBirth: formattedDate,
                              ),
                            );
                          },
                        );
                      },
                    ).animate().fadeIn(duration: 1200.ms).moveY(begin: 20, end: 0),

                    const SizedBox(height: 25),

                    /// Continue Button
                    SizedBox(
                          width: 220,
                          height: 48,
                          child: CustomGradientButton(
                            text: "Continue",
                            textColor: AppColors.primaryColor,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (selectedDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please select your date of birth",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  );
                                  return;
                                }

                                int age = calculateAge(selectedDate!);
                                if (age >= 21) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: signUpBloc, // same bloc instance
                                        child: const UserDetailsScreen(),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "You must be at least 21 years old",
                                      ),
                                      backgroundColor: AppColors.mehroon,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 1000.ms)
                        .moveY(begin: 15, end: 0),

                    const SizedBox(height: 20),

                    Text(
                          "This helps us create a more personalized experience",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 1200.ms)
                        .moveY(begin: 20, end: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
