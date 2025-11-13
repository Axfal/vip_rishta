import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/route/route_exports.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';

class RequestOTP extends StatefulWidget {
  const RequestOTP({super.key});

  @override
  State<RequestOTP> createState() => _RequestOTPState();
}

class _RequestOTPState extends State<RequestOTP> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void submitEmail() {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
      Navigator.pushNamed(context, RoutesName.verifyOtp);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP sent to your email!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: size.height * 0.12,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Logo
                  Image.asset('assets/logo/vip_rishta.png', height: 110)
                      .animate()
                      .fade(duration: 900.ms)
                      .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 18),

                  /// App Title
                  Text(
                    "VIP Rishta",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ).animate().fade(duration: 900.ms).moveY(begin: 14, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    "Enter your email to receive OTP.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ).animate().fade(duration: 1100.ms).moveY(begin: 18, end: 0),

                  const SizedBox(height: 40),

                  /// Email field
                  CustomTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  /// Submit Button
                  GestureDetector(
                    onTap: submitEmail,
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
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
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
                  ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
