import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/route/routes.dart';
import 'package:rishta_app/data/response/status.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/screens/auth/forgot_password/verify_otp.dart';
import 'package:rishta_app/services/flush_bar_servces.dart';

import '../../../dependency_indjection/locator.dart';
import '../../../repo/auth/auth_api_repo.dart';

class RequestOTP extends StatefulWidget {
  const RequestOTP({super.key});

  @override
  State<RequestOTP> createState() => _RequestOTPState();
}

class _RequestOTPState extends State<RequestOTP> {
  late ForgotPasswordBloc _forgotPassword;
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgotPassword = ForgotPasswordBloc(authApiRepo: getIt<AuthApiRepo>());
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void submitEmail() {
    if (!formKey.currentState!.validate()) return;
    _forgotPassword.add(const RequestOTPEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _forgotPassword,
      child: Scaffold(
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
                    /// LOGO
                    Image.asset('assets/logo/vip_rishta.png', height: 110)
                        .animate()
                        .fade(duration: 900.ms)
                        .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                    const SizedBox(height: 18),

                    /// APP NAME
                    Text(
                      "VIP Rishta",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ).animate().fade(duration: 900.ms).moveY(begin: 14, end: 0),

                    const SizedBox(height: 8),

                    /// SUBTEXT
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

                    /// EMAIL FIELD
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      buildWhen: (current, previous) =>
                      current.email != previous.email,
                      builder: (context, state) {
                        return CustomTextField(
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
                          onChange: (value) {
                            _forgotPassword
                                .add(EmailChangeEvent(email: value));
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    /// SUBMIT BUTTON
                    BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                      buildWhen: (current, previous) =>
                      current.apiResponse.status != previous.apiResponse.status,
                      listener: (context, state) {
                        if (state.apiResponse.status == Status.error) {
                          FlushbarService.showError(
                            context,
                            state.apiResponse.message ?? "",
                          );
                        } else if (state.apiResponse.status == Status.completed &&
                            state.apiResponse.data != null &&
                            state.apiResponse.data!.isNotEmpty) {
                          FlushbarService.showSuccess(
                            context,
                            state.apiResponse.data ?? "OTP sent via email",
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: _forgotPassword,
                                child: const VerifyOtp(),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final loading =
                            state.apiResponse.status == Status.loading;

                        return GestureDetector(
                          onTap: loading ? null : submitEmail,
                          child: AnimatedContainer(
                            duration: 400.ms,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(
                                  alpha: loading ? 0.7 : 0.95),
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
                            child: loading
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
                        );
                      },
                    ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
