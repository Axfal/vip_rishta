import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/name_and_birth_date.dart';

import '../../../../../../bloc/auth/signup/sign_up_bloc.dart';

class ProfileSelection extends StatefulWidget {
  const ProfileSelection({super.key});

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  String? selectedProfile;
  String? selectedGender;

  final List<String> profileOptions = [
    "Myself",
    "My Son",
    "My Daughter",
    "My Brother",
    "My Sister",
    "My Friend",
    "My Relative",
  ];

  final List<String> profilesNeedGender = [
    "Myself",
    "My Friend",
    "My Relative",
  ];

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();

    bool showGender =
        selectedProfile != null && profilesNeedGender.contains(selectedProfile);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          children: [
            Positioned(
              top: 120,
              left: 40,
              child:
                  Icon(
                        Icons.favorite,
                        size: 36,
                        color: AppColors.white.withValues(alpha: 0.25),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: -15,
                        duration: 2200.ms,
                        curve: Curves.easeInOut,
                      ),
            ),
            Positioned(
              bottom: 160,
              right: 50,
              child:
                  Icon(
                        Icons.favorite,
                        size: 30,
                        color: AppColors.white.withValues(alpha: 0.20),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: 18,
                        duration: 2400.ms,
                        curve: Curves.easeInOut,
                      ),
            ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo/vip_rishta.png', height: 110)
                      .animate()
                      .fade(duration: 900.ms)
                      .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 18),

                  Text(
                        "This Profile is for",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      .animate()
                      .fade(duration: 900.ms)
                      .moveY(begin: 15, end: 0, curve: Curves.easeOut),

                  const SizedBox(height: 18),

                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.profileCreatedFor !=
                            previous.profileCreatedFor ||
                        current.gender != previous.gender,
                    builder: (context, state) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: profileOptions.map((option) {
                          final isSelected = selectedProfile == option;

                          return ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Text(
                                option,
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 13.5,
                                ),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                selectedProfile = option;

                                if (option == "My Son") {
                                  selectedGender = "Male";
                                  signUpBloc.add(
                                    GenderChangeEvent(gender: "Male"),
                                  );
                                } else if (option == "My Daughter") {
                                  selectedGender = "Female";
                                  signUpBloc.add(
                                    GenderChangeEvent(gender: "Female"),
                                  );
                                } else if (option == 'My Brother') {
                                  selectedGender = "Male";
                                  signUpBloc.add(
                                    GenderChangeEvent(gender: "Female"),
                                  );
                                } else if (option == 'My Sister') {
                                  selectedGender = "Female";
                                  signUpBloc.add(
                                    GenderChangeEvent(gender: "Female"),
                                  );
                                } else {
                                  selectedGender = null;
                                }

                                // Trigger profile event
                                signUpBloc.add(
                                  ProfileCreatedForChangeEvent(
                                    profileCreatedFor: option,
                                  ),
                                );
                              });
                            },
                            selectedColor: AppColors.white,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.4),
                              ),
                            ),
                            elevation: 2,
                          ).animate().fade(duration: 700.ms);
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 35),

                  if (showGender) ...[
                    Text(
                      "Select Gender",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fade(duration: 800.ms).moveY(begin: 12, end: 0),
                    const SizedBox(height: 16),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (current, previous) =>
                          current.profileCreatedFor !=
                              previous.profileCreatedFor ||
                          current.gender != previous.gender,
                      builder: (context, state) {
                        return Wrap(
                          spacing: 14,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: ["Male", "Female"].map((gender) {
                            final isSelected = selectedGender == gender;
                            return ChoiceChip(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Text(
                                  gender,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryColor,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  selectedGender = gender;
                                  signUpBloc.add(
                                    GenderChangeEvent(gender: gender),
                                  );
                                });
                              },
                              selectedColor: AppColors.white,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ).animate().fade(duration: 900.ms).moveY(begin: 12, end: 0),
                    const SizedBox(height: 40),
                  ],

                  SizedBox(
                        width: 220,
                        height: 48,
                        child: CustomGradientButton(
                          text: 'Continue',
                          textColor: AppColors.primaryColor,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            if (selectedProfile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select a profile option",
                                  ),
                                ),
                              );
                              return;
                            }
                            if (showGender && selectedGender == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select your gender"),
                                ),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: signUpBloc,
                                  child: NameAndBirthDate(
                                    profileFor: selectedProfile!,
                                    gender: selectedGender,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .animate()
                      .fade(duration: 1000.ms)
                      .moveY(begin: 20, end: 0, curve: Curves.easeOutBack),

                  const SizedBox(height: 25),

                  Text(
                    "We use this information to personalize your experience",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate().fade(duration: 1200.ms).moveY(begin: 12, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
