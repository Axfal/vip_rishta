import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:rishta_app/bloc/auth/signup/sign_up_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';
import 'package:rishta_app/core/route/routes_name.dart';
import 'package:rishta_app/dependency_indjection/locator.dart';
import 'package:rishta_app/global_widgets/auth/text_fields.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';
import 'package:rishta_app/screens/auth/signup/widgets/mbl_signup/widgets/profile_selection.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpBloc _signUpBloc;
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String countryCode = "+92";
  final List<String> countryCodes = ["+92", "+91", "+1", "+44"];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = SignUpBloc(authApiRepo: getIt<AuthApiRepo>());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider.value(
        value: _signUpBloc,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
          child: SingleChildScrollView(
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
                    "Create your account to continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ).animate().fade(duration: 1100.ms).moveY(begin: 18, end: 0),

                  const SizedBox(height: 40),

                  /// Email Field
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (current, previous) =>
                        current.email != previous.email,
                    builder: (context, state) {
                      return CustomTextField(
                        controller: emailController,
                        hintText: "Enter your email",
                        labelText: "Email ID",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        onChange: (value) {
                          _signUpBloc.add(EmailChangeEvent(email: value));
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Mobile Number + Country Code
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.mehroon,
                            value: countryCode,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            style: AppText.body.copyWith(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                countryCode = newValue!;
                              });
                            },
                            items: countryCodes.map<DropdownMenuItem<String>>((
                              String code,
                            ) {
                              return DropdownMenuItem<String>(
                                value: code,
                                child: Text(
                                  code,
                                  style: AppText.body.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          buildWhen: (current, previous) =>
                              current.mobile != previous.mobile,
                          builder: (context, state) {
                            return CustomTextField(
                              labelText: 'Mobile Number',
                              controller: phoneController,
                              hintText: "Enter mobile number",
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Mobile number is required";
                                }
                                if (value.length < 10) {
                                  return "Enter a valid number";
                                }
                                return null;
                              },
                              onChange: (value) {
                                _signUpBloc.add(
                                  MobileChangeEvent(
                                    mobile: "$countryCode $value",
                                  ),
                                );
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Password field
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    labelText: "Password",
                    obscureText: isPasswordHidden,
                    onChange: (value) {
                      _signUpBloc.add(PasswordChangeEvent(password: value));
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () =>
                          setState(() => isPasswordHidden = !isPasswordHidden),
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
                  const SizedBox(height: 40),

                  /// Next Button
                  GestureDetector(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: _signUpBloc,
                            child: const ProfileSelection(),
                          ),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: 400.ms,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.95),
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
                              "Next",
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ).animate().fade(duration: 1000.ms).moveY(begin: 10, end: 0),

                  const SizedBox(height: 24),

                  /// Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppText.caption.copyWith(
                          color: AppColors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        child: Text(
                          "Login",
                          style: AppText.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Terms and Conditions
                  Text.rich(
                    TextSpan(
                      text: "By creating an account, you agree to our ",
                      style: AppText.caption.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: AppText.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: AppText.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
