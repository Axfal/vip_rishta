import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/constants/custom_button.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/marital_status.dart';

class WorkDetail extends StatefulWidget {
  const WorkDetail({super.key});

  @override
  State<WorkDetail> createState() => _WorkDetailState();
}

class _WorkDetailState extends State<WorkDetail> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _workLocationController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();

  final List<String> incomeOptions = [
    "20000",
    "30000",
    "40000",
    "50000",
    "60000",
    "70000",
    "80000",
    "90000",
    "100000",
    "110000",
    "120000",
    "130000",
    "140000",
    "150000",
  ];

  final List<String> locationOptions = [
    "Office",
    "Home",
    "School",
    "Hospital",
    "Factory",
    "Other",
  ];

  final List<String> jobTypeOptions = [
    "Government",
    "Private",
    "Self-employed",
    "Freelancer",
    "Unemployed",
  ];

  // Bottom Picker
  void _openPicker({
    required List<String> options,
    required TextEditingController controller,
    required String title,
    required void Function(String) onSelect, // Added callback
  }) {
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
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          controller.text = option;
                          onSelect(option); // Fire the BLoC event
                          Navigator.pop(context);
                          setState(() {});
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
                            option,
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: signupBloc,
            child: const MaritalStatus(),
          ),
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
    final size = MediaQuery.of(context).size;
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: size.height * 0.12,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// Logo
                Image.asset('assets/logo/vip_rishta.png', height: 110)
                    .animate()
                    .fade(duration: 900.ms)
                    .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                const SizedBox(height: 18),

                Text(
                  "Enter your work details",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fade(duration: 900.ms).moveY(begin: 14, end: 0),

                const SizedBox(height: 40),

                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (current, previous) =>
                      current.monthlyIncome != previous.monthlyIncome,
                  builder: (context, state) {
                    return CustomTextField(
                      controller: _incomeController,
                      hintText: "Select Annual Income",
                      labelText: "Annual Income",
                      isDropdown: true,
                      onTap: () => _openPicker(
                        options: incomeOptions,
                        controller: _incomeController,
                        title: "Select Income Range",
                        onSelect: (value) {
                          signUpBloc.add(
                            MonthlyIncomeChangeEvent(monthlyIncome: value),
                          );
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Annual income is required";
                        }
                        return null;
                      },
                    );
                  },
                ).animate().fade(duration: 800.ms).moveY(begin: 10, end: 0),

                const SizedBox(height: 18),

                if (_incomeController.text.isNotEmpty) ...[
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.job != previous.job,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _jobTitleController,
                        hintText: "e.g. Teacher, Engineer",
                        labelText: "Your Work",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        onChange: (value) {
                          signUpBloc.add(JobChangeEvent(job: value));
                        },
                      );
                    },
                  ).animate().fade(duration: 900.ms).moveY(begin: 10, end: 0),
                  const SizedBox(height: 18),

                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.workLocation != previous.workLocation,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _workLocationController,
                        hintText: "Select work location",
                        labelText: "Work Location",
                        isDropdown: true,
                        onTap: () => _openPicker(
                          options: locationOptions,
                          controller: _workLocationController,
                          title: "Select Work Location",
                          onSelect: (value) {
                            signUpBloc.add(
                              WorkLocationChangeEvent(workLocation: value),
                            );
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Work location is required";
                          }
                          return null;
                        },
                      );
                    },
                  ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),
                  const SizedBox(height: 18),

                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.jobType != previous.jobType,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: _jobTypeController,
                        hintText: "Select job type",
                        labelText: "Job Type",
                        isDropdown: true,
                        onTap: () => _openPicker(
                          options: jobTypeOptions,
                          controller: _jobTypeController,
                          title: "Select Job Type",
                          onSelect: (value) {
                            signUpBloc.add(JobTypeChangeEvent(jobType: value));
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Job type is required";
                          }
                          return null;
                        },
                      );
                    },
                  ).animate().fade(duration: 1100.ms).moveY(begin: 10, end: 0),
                  const SizedBox(height: 40),
                ],

                // Continue Button
                GestureDetector(
                  onTap: () => _submitForm(signUpBloc),
                  child: AnimatedContainer(
                    duration: 400.ms,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
