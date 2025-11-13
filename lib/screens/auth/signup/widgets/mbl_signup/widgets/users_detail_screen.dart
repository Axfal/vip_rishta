import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/add_family_details.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _communityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _openSelection(
    TextEditingController controller,
    String title,
    List<String> options,
    SignUpBloc signUpBloc,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: AppColors.Linear_gradient,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ...options.map(
                (e) => ListTile(
                  title: Text(
                    e,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    controller.text = e;

                    // Update BLoC state immediately
                    if (controller == _religionController) {
                      signUpBloc.add(ReligionChangeEvent(religion: e));
                    } else if (controller == _communityController) {
                      signUpBloc.add(CommunityChangeEvent(community: e));
                    } else if (controller == _countryController) {
                      signUpBloc.add(CountryChangeEvent(country: e));
                    } else if (controller == _stateController) {
                      signUpBloc.add(StateRegionChangeEvent(stateRegion: e));
                    } else if (controller == _cityController) {
                      signUpBloc.add(CityChangeEvent(city: e));
                    }

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _validateAndContinue(SignUpBloc signupBloc) {
    if (_religionController.text.isEmpty ||
        _communityController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _cityController.text.isEmpty) {
      _showError("Please fill all the details");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: signupBloc,
            child: const AddFamilyDetails(),
          ),
        ),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  /// Logo
                  Image.asset('assets/logo/vip_rishta.png', height: 110)
                      .animate()
                      .fade(duration: 900.ms)
                      .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 18),

                  /// Religion Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.religion != previous.religion,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _religionController,
                        hintText: "Select Religion",
                        labelText: "Religion",
                        isDropdown: true,
                        onTap: () => _openSelection(
                          _religionController,
                          "Select Religion",
                          ["Muslim", "Christian", "Hindu", "Other"],
                          signUpBloc,
                        ),
                        onChange: (value) {
                          signUpBloc.add(ReligionChangeEvent(religion: value));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  /// Community Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.community != previous.community,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _communityController,
                        hintText: "Select Community",
                        labelText: "Community",
                        isDropdown: true,
                        onTap: () => _openSelection(
                          _communityController,
                          "Select Community",
                          ["Urdu", "Punjabi", "Sindhi", "Pashto"],
                          signUpBloc,
                        ),
                        onChange: (value) {
                          signUpBloc.add(
                            CommunityChangeEvent(community: value),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  /// Country Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.country != previous.country,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _countryController,
                        hintText: "Select Country",
                        labelText: "Country",
                        isDropdown: true,
                        onTap: () => _openSelection(
                          _countryController,
                          "Select Country",
                          ["Pakistan", "India", "UK", "USA"],
                          signUpBloc,
                        ),
                        onChange: (value) {
                          signUpBloc.add(CountryChangeEvent(country: value));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  /// State Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.stateRegion != previous.stateRegion,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _stateController,
                        hintText: "Select State",
                        labelText: "State",
                        isDropdown: true,
                        onTap: () => _openSelection(
                          _stateController,
                          "Select State",
                          ["Punjab", "Sindh", "KPK", "Balochistan"],
                          signUpBloc,
                        ),
                        onChange: (value) {
                          signUpBloc.add(
                            StateRegionChangeEvent(stateRegion: value),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  /// City Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.city != previous.city,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _cityController,
                        hintText: "Select City",
                        labelText: "City",
                        isDropdown: true,
                        onTap: () => _openSelection(
                          _cityController,
                          "Select City",
                          ["Lahore", "Karachi", "Islamabad", "Peshawar"],
                          signUpBloc,
                        ),
                        onChange: (value) {
                          signUpBloc.add(CityChangeEvent(city: value));
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  /// Continue Button
                  Center(
                    child: Container(
                      width: 220,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: AppColors.Linear_gradient,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CustomGradientButton(
                        text: 'Continue',
                        textColor: AppColors.primaryColor,
                        backgroundColor: Colors.white,
                        onPressed: () => _validateAndContinue(signUpBloc),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
