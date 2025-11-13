import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/height_diet_hobbies.dart';

import '../../../../../../global_widgets/auth/text_fields.dart';

class AddFamilyDetails extends StatefulWidget {
  const AddFamilyDetails({super.key});

  @override
  State<AddFamilyDetails> createState() => _AddFamilyDetailsState();
}

class _AddFamilyDetailsState extends State<AddFamilyDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mothernameController = TextEditingController();
  final TextEditingController _fathernameController = TextEditingController();
  final TextEditingController _sistersController = TextEditingController();
  final TextEditingController _brotherController = TextEditingController();

  void _openSelection(
    TextEditingController controller,
    String title,
    List<String> options,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child:
              Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.Linear_gradient,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...options.map(
                          (e) => ListTile(
                            title: Text(
                              e,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                              ),
                            ),
                            onTap: () {
                              controller.text = e;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .scale(duration: 500.ms, curve: Curves.easeOutBack),
        );
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          children: [
            // Floating hearts animation
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
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset('assets/logo/vip_rishta.png', height: 100)
                              .animate()
                              .fade(duration: 800.ms)
                              .scale(
                                duration: 1000.ms,
                                curve: Curves.easeOutBack,
                              ),
                          const SizedBox(height: 12),
                          Text(
                                "Family Details",
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              )
                              .animate()
                              .fade(duration: 800.ms)
                              .moveY(begin: 10, end: 0),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (current, previous) =>
                                current.motherName != previous.motherName,
                            builder: (context, state) {
                              return CustomTextField(
                                controller: _mothernameController,
                                hintText: "Enter your Mother name",
                                labelText: "Mother name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Mother name is required";
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  signUpBloc.add(
                                    MotherNameChangeEvent(motherName: value),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),

                          BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (current, previous) =>
                                current.fatherName != previous.fatherName,
                            builder: (context, state) {
                              return CustomTextField(
                                controller: _fathernameController,
                                hintText: "Enter your Father name",
                                labelText: "Father name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Father name is required";
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  signUpBloc.add(
                                    FatherNameChangeEvent(fatherName: value),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),

                          BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (current, previous) =>
                                current.numberOfSister !=
                                previous.numberOfSister,
                            builder: (context, state) {
                              return CustomTextField(
                                controller: _sistersController,
                                hintText: "Select No.of Sisters",
                                labelText: "No. of Sisters",
                                isDropdown: true,
                                onTap: () => _openSelection(
                                  _sistersController,
                                  "Select No.of Sisters",
                                  ["0", "1", "2", "3", "4", "5"],
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "No. of Sisters") {
                                    return "Please select number of sisters";
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  final int? number = int.tryParse(value);
                                  signUpBloc.add(
                                    NumberOfSisterChangeEvent(
                                      numberOfSister: number ?? 0,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),

                          BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (current, previous) =>
                                current.numberOfBrother !=
                                previous.numberOfBrother,
                            builder: (context, state) {
                              return CustomTextField(
                                controller: _brotherController,
                                hintText: "Select No.of Brothers",
                                labelText: "No. of Brothers",
                                isDropdown: true,
                                onTap: () => _openSelection(
                                  _brotherController,
                                  "Select No.of Brothers",
                                  ["0", "1", "2", "3", "4", "5"],
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "No. of Brothers") {
                                    return "Please select number of brothers";
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  final int? number = int.tryParse(value);
                                  signUpBloc.add(
                                    NumberOfBrotherChangeEvent(
                                      numberOfBrother: number ?? 0,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 40),

                          Center(
                            child: SizedBox(
                              width: 220,
                              height: 50,
                              child: CustomGradientButton(
                                text: 'Continue',
                                textColor: AppColors.primaryColor,
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: signUpBloc,
                                              child: const HeightDietHobbies(),
                                            ),
                                      ),
                                    );
                                  } else {
                                    _showError(
                                      "Please fill all the required details",
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
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
    );
  }
}
