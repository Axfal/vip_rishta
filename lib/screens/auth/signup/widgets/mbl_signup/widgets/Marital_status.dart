import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/route/route_exports.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/services/flush_bar_servces.dart';
import '../../../../../../data/response/status.dart';

class MaritalStatus extends StatefulWidget {
  const MaritalStatus({super.key});

  @override
  State<MaritalStatus> createState() => _MaritalStatusState();
}

class _MaritalStatusState extends State<MaritalStatus> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _maritalStatusController =
  TextEditingController();
  final TextEditingController _numberOfChildrenController =
  TextEditingController();

  final List<String> maritalStatusOptions = [
    "Never Married",
    "Divorced",
    "Widowed",
    "Awaiting Divorce",
    "Annulled",
  ];

  final List<String> numberOfChildrenOptions = ["0", "1", "2", "3", "4+"];

  void _openPicker({
    required List<String> options,
    required TextEditingController controller,
    required String title,
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
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 60,
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
                      return ListTile(
                        title: Text(
                          option,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          controller.text = option;
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(const SubmitSignUpEvent());
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
  void initState() {
    super.initState();
    final state = context.read<SignUpBloc>().state;
    _maritalStatusController.text = state.maritalStatus;
    _numberOfChildrenController.text = state.children;
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signUpBloc = context.read<SignUpBloc>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                Image.asset('assets/logo/vip_rishta.png', height: 110)
                    .animate()
                    .fade(duration: 900.ms)
                    .scale(duration: 1200.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 18),

                /// Title
                Text(
                  "Marital Status",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ).animate().fade(duration: 900.ms).moveY(begin: 14, end: 0),
                const SizedBox(height: 10),
                Text(
                  "Please select your marital details below",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fade(duration: 1000.ms).moveY(begin: 16, end: 0),
                const SizedBox(height: 40),

                /// Marital Status
                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (current, previous) =>
                  current.maritalStatus != previous.maritalStatus,
                  builder: (context, state) {
                    // Only update controller if state is not empty
                    if (_maritalStatusController.text.isEmpty &&
                        state.maritalStatus.isNotEmpty) {
                      _maritalStatusController.text = state.maritalStatus;
                    }
                    return CustomTextField(
                      controller: _maritalStatusController,
                      hintText: "Select Marital Status",
                      labelText: "Marital Status",
                      isDropdown: true,
                      onTap: () => _openPicker(
                        options: maritalStatusOptions,
                        controller: _maritalStatusController,
                        title: "Select Marital Status",
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Marital status is required"
                          : null,
                      onChange: (value) {
                        signUpBloc.add(
                          MaritalStatusChangeEvent(maritalStatus: value),
                        );
                      },
                    );
                  },
                ).animate().fade(duration: 1000.ms).moveY(begin: 12, end: 0),

                const SizedBox(height: 20),

                /// Number of Children
                if(_maritalStatusController.text != "Never Married")
                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (current, previous) =>
                  current.children != previous.children,
                  builder: (context, state) {
                    if (_numberOfChildrenController.text.isEmpty &&
                        state.children.isNotEmpty) {
                      _numberOfChildrenController.text = state.children;
                    }
                    return CustomTextField(
                      controller: _numberOfChildrenController,
                      hintText: "Select number of children",
                      labelText: "Number of Children",
                      isDropdown: true,
                      onTap: () => _openPicker(
                        options: numberOfChildrenOptions,
                        controller: _numberOfChildrenController,
                        title: "Select Number of Children",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select number of children";
                        }
                        return null;
                      },
                      onChange: (value) {
                        signUpBloc.add(ChildrenChangeEvent(children: value));
                      },
                    );
                  },
                ).animate().fade(duration: 1000.ms).moveY(begin: 12, end: 0),

                const SizedBox(height: 45),

                /// Submit Button
                BlocConsumer<SignUpBloc, SignUpState>(
                  buildWhen: (current, previous) =>
                  current.apiResponse.status != previous.apiResponse.status,
                  listener: (context, state) {
                    if (state.apiResponse.status == Status.completed) {
                      FlushbarService.showSuccess(
                        context,
                        'Account created successfully',
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.login,
                            (route) => false,
                      );
                    } else if (state.apiResponse.status == Status.error) {
                      FlushbarService.showError(
                        context,
                        state.apiResponse.message ??
                            'Error while creating account',
                      );
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: _submitForm,
                      child: AnimatedContainer(
                        duration: 400.ms,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: state.apiResponse.status == Status.loading
                            ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                            : Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
