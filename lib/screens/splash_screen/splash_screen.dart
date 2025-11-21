import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/profile/profile_bloc.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/services/splash_service.dart';

import '../../bloc/match/match_bloc.dart';
import '../../core/route/routes_name.dart';
import '../../services/user_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashService = SplashServices();
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    await SessionController().getUserFromPreference();

    if (SessionController.isLogin) {
      if (!mounted) return;
      context.read<MatchBloc>().add(SuggestedMatchEvent());
      context.read<ProfileBloc>().add(GetProfileEvent());
      _goToHome();
    } else {
      _goToLogin();
    }
  }

  void _goToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.home,
      (route) => false,
    );
  }

  void _goToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Floating heart (ambient)
            Positioned(
              top: 140,
              child:
                  Icon(
                        Icons.favorite,
                        size: 38,
                        color: AppColors.white.withValues(alpha: 0.25),
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
              child:
                  Icon(
                        Icons.favorite,
                        size: 28,
                        color: AppColors.white.withValues(alpha: 0.22),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: 20,
                        duration: 2200.ms,
                        curve: Curves.easeInOut,
                      ),
            ),

            /// Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo/vip_rishta.png', height: 130)
                    .animate()
                    .fade(duration: 900.ms)
                    .scale(duration: 1200.ms, curve: Curves.easeOutBack),

                const SizedBox(height: 22),

                Text(
                      "پکے رشتے",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    )
                    .animate()
                    .fade(duration: 900.ms)
                    .moveY(begin: 14, end: 0, curve: Curves.easeOut),

                const SizedBox(height: 16),

                Text(
                      "Where Souls Meet With Respect",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.white.withValues(alpha: 0.90),
                      ),
                    )
                    .animate()
                    .fade(duration: 1100.ms)
                    .moveY(begin: 18, end: 0, curve: Curves.easeOut),

                const SizedBox(height: 36),

                /// Loading Bar
                Container(
                  height: 4,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.white.withValues(alpha: 0.25),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Container(
                              height: 4,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.white,
                              ),
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .moveX(
                              begin: 0,
                              end: 80,
                              duration: 1200.ms,
                              curve: Curves.easeInOut,
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
