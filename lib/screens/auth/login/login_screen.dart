import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/route/routes_name.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import '../../../bloc/auth/login/login_bloc.dart';
import '../../../data/response/status.dart';
import '../../../dependency_indjection/locator.dart';
import '../../../repo/auth/auth_api_repo.dart';
import '../../../services/flush_bar_servces.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(authApiRepo: getIt<AuthApiRepo>());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        buildWhen: (current, previous) =>
            current.email != previous.email ||
            current.password != previous.password ||
            current.apiResponse.status != previous.apiResponse.status,
        listener: (context, state) {
          final response = state.apiResponse;

          if (response.status == Status.error &&
              response.message?.isNotEmpty == true) {
            FlushbarService.showError(context, response.message!);
          } else if (response.status == Status.completed &&
              response.data != '' &&
              response.data == 'Login Successful') {
            FlushbarService.showSuccess(
              context,
              response.message ?? 'Login successful!',
            );

            // Navigate to home after a short delay
            Future.delayed(const Duration(milliseconds: 400), () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.home,
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          final isLoading = state.apiResponse.status == Status.loading;

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
                            .scale(
                              duration: 1200.ms,
                              curve: Curves.easeOutBack,
                            ),

                        const SizedBox(height: 18),

                        /// App Title
                        Text(
                              "VIP Rishta",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            )
                            .animate()
                            .fade(duration: 900.ms)
                            .moveY(begin: 14, end: 0),

                        const SizedBox(height: 8),

                        Text(
                              "Welcome Back! Please log in to continue.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.white.withOpacity(0.85),
                              ),
                            )
                            .animate()
                            .fade(duration: 1100.ms)
                            .moveY(begin: 18, end: 0),

                        const SizedBox(height: 40),

                        /// Email field
                        CustomTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          onChange: (value) {
                            _loginBloc.add(EmailChangeEvent(email: value));
                            _loginBloc.add(ResetApiResponse());
                          },

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

                        const SizedBox(height: 20),

                        /// Password field
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Enter your password",
                          labelText: "Password",
                          obscureText: isPasswordHidden,
                          onChange: (value) {
                            _loginBloc.add(
                              PasswordChangeEvent(password: value),
                            );
                            _loginBloc.add(ResetApiResponse());
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () => setState(
                              () => isPasswordHidden = !isPasswordHidden,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        /// Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.forgot,
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: AppText.caption.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// Login Button
                        GestureDetector(
                              onTap: () {
                                if (!formKey.currentState!.validate()) return;
                                _loginBloc.add(SubmitCredentials());
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
                                        "Login",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            )
                            .animate()
                            .fade(duration: 1000.ms)
                            .moveY(begin: 10, end: 0),

                        const SizedBox(height: 24),

                        /// Signup Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppText.caption.copyWith(
                                color: AppColors.white.withOpacity(0.85),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.signup);
                              },
                              child: Text(
                                "Sign up",
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
        },
      ),
    );
  }
}
