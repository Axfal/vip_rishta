import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/route/routes_name.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
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
                    "Enter the 6-digit code sent to your email.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.white.withOpacity(0.85),
                    ),
                  ).animate().fade(duration: 1100.ms).moveY(begin: 18, end: 0),

                  const SizedBox(height: 40),

                  /// OTP Field
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    autoDisposeControllers: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeFillColor: AppColors.white.withOpacity(0.2),
                      inactiveFillColor: AppColors.white.withOpacity(0.15),
                      selectedFillColor: AppColors.white.withOpacity(0.25),
                      activeColor: AppColors.white,
                      selectedColor: AppColors.white,
                      inactiveColor: AppColors.white,
                    ),
                    cursorColor: AppColors.white,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    onChanged: (value) {},
                  ).animate().fade(duration: 900.ms).moveY(begin: 10, end: 0),

                  const SizedBox(height: 30),

                  /// Verify Button
                  GestureDetector(
                    onTap: () {
                      if (otpController.text.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid 6-digit code'),
                          ),
                        );
                        return;
                      }

                      // TODO: Add your OTP verification logic here

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.home,
                        (route) => false,
                      );
                    },
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
                        "Verify",
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),

                  const SizedBox(height: 24),

                  /// Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: AppText.caption.copyWith(
                          color: AppColors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          // TODO: Add resend OTP logic here
                        },
                        child: Text(
                          "Resend",
                          style: AppText.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
