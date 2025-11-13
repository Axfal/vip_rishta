import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/qualification.dart';

class HeightDietHobbies extends StatefulWidget {
  const HeightDietHobbies({super.key});

  @override
  State<HeightDietHobbies> createState() => _HeightDietHobbiesState();
}

class _HeightDietHobbiesState extends State<HeightDietHobbies> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _dietController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();

  List<String> selectedHobbies = [];

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

  void _openSelection({
    required String title,
    required List<String> options,
    required TextEditingController controller,
    required SignUpBloc signUpBloc, // added
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child:
                Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.Linear_gradient,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 60,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                                title,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              )
                              .animate()
                              .fade(duration: 400.ms)
                              .moveY(begin: 10, end: 0),
                          const SizedBox(height: 12),
                          ...options.map(
                            (e) => ListTile(
                              title: Text(
                                e,
                                style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                controller.text = e;

                                if (controller == _heightController) {
                                  signUpBloc.add(HeightChangeEvent(height: e));
                                } else if (controller == _dietController) {
                                  signUpBloc.add(DietChangeEvent(diet: e));
                                }

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fade(duration: 400.ms)
                    .scale(duration: 500.ms, curve: Curves.easeOutBack),
          ),
        );
      },
    );
  }

  void _openHobbiesSelection(SignUpBloc signupBloc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.Linear_gradient,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    left: 16,
                    right: 16,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: 60,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Text(
                            "Select Hobbies",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          )
                          .animate()
                          .fade(duration: 400.ms)
                          .moveY(begin: 10, end: 0),
                      const SizedBox(height: 12),
                      ...hobbyOptions.map(
                        (hobby) => CheckboxListTile(
                          title: Text(
                            hobby,
                            style: GoogleFonts.poppins(color: AppColors.white),
                          ),
                          value: selectedHobbies.contains(hobby),
                          activeColor: AppColors.primaryColor,
                          checkColor: Colors.white,
                          onChanged: (bool? selected) {
                            setModalState(() {
                              if (selected != null && selected) {
                                if (!selectedHobbies.contains(hobby)) {
                                  selectedHobbies.add(hobby);
                                }
                              } else {
                                selectedHobbies.remove(hobby);
                              }
                              _hobbiesController.text = selectedHobbies.join(
                                ", ",
                              );
                            });
                            signupBloc.add(
                              HobbiesChangeEvent(hobbies: selectedHobbies),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
                .animate()
                .fade(duration: 400.ms)
                .scale(duration: 500.ms, curve: Curves.easeOutBack);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          children: [
            Positioned(
              top: 140,
              left: 50,
              child:
                  Icon(
                        Icons.favorite,
                        size: 38,
                        color: AppColors.white.withOpacity(0.25),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: -15,
                        duration: 2000.ms,
                        curve: Curves.easeInOut,
                      ),
            ),
            Positioned(
              bottom: 180,
              right: 50,
              child:
                  Icon(
                        Icons.favorite,
                        size: 28,
                        color: AppColors.white.withOpacity(0.22),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: 20,
                        duration: 2200.ms,
                        curve: Curves.easeInOut,
                      ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Logo
                    Image.asset('assets/logo/vip_rishta.png', height: 110)
                        .animate()
                        .fade(duration: 900.ms)
                        .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                    const SizedBox(height: 18),

                    Text(
                      "Height, Diet & Hobbies",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ).animate().fade(duration: 800.ms).moveY(begin: 10, end: 0),
                    const SizedBox(height: 30),

                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (current, previous) =>
                          current.height != previous.height,
                      builder: (context, state) {
                        return CustomTextField(
                          controller: _heightController,
                          hintText: "Select Height",
                          labelText: "Height",
                          isDropdown: true,
                          onTap: () => _openSelection(
                            title: "Select Height",
                            options: heightOptions,
                            controller: _heightController,
                            signUpBloc: signUpBloc, // pass bloc
                          ),
                          onChange: (value) {
                            signUpBloc.add(HeightChangeEvent(height: value));
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (current, previous) =>
                          current.diet != previous.diet,
                      builder: (context, state) {
                        return CustomTextField(
                          controller: _dietController,
                          hintText: "Select Diet",
                          labelText: "Diet",
                          isDropdown: true,
                          onTap: () => _openSelection(
                            title: "Select Diet",
                            options: dietOptions,
                            controller: _dietController,
                            signUpBloc: signUpBloc, // pass bloc
                          ),
                          onChange: (value) {
                            signUpBloc.add(DietChangeEvent(diet: value));
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 18),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (current, previous) =>
                          current.hobbies != previous.hobbies,
                      builder: (context, state) {
                        return CustomTextField(
                          controller: _hobbiesController,
                          hintText: "Select Hobbies",
                          labelText: "Hobbies",
                          isDropdown: true,
                          onTap: () => _openHobbiesSelection(signUpBloc),
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Continue button
                    SizedBox(
                      width: 220,
                      height: 50,
                      child:
                          CustomGradientButton(
                                text: 'Continue',
                                textColor: AppColors.primaryColor,
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  if (_heightController.text.isEmpty ||
                                      _dietController.text.isEmpty ||
                                      selectedHobbies.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please fill all the fields.",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        backgroundColor: Colors.white,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: signUpBloc,
                                              child: const Qualification(),
                                            ),
                                      ),
                                    );
                                  }
                                },
                              )
                              .animate()
                              .fade(duration: 500.ms)
                              .moveY(begin: 20, end: 0),
                    ),
                    const SizedBox(height: 30),
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
