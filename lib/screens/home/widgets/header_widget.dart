import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/color/app_color.dart';
import '../../../core/constants/text/app_text.dart';
import '../../../core/constants/custom_button.dart';

class HeaderWidget extends StatelessWidget {
  final String imgUrl;
  final String userName;
  final int age;
  final String location;
  final bool isPremium;
  final bool isOnline;
  final String tagline;

  final String likes;
  final String matches;
  final String views;

  const HeaderWidget({
    super.key,
    required this.imgUrl,
    required this.userName,
    required this.age,
    required this.location,
    this.isPremium = false,
    this.isOnline = false,
    this.tagline = '',
    required this.likes,
    required this.matches,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: InwardArchClipper(),
      child: Container(
        height: size.height * 0.40,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.Linear_gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// Floating Hearts Background (Like Splash)
            Positioned(
              top: 40,
              left: 40,
              child:
              Icon(
                Icons.favorite,
                size: 26,
                color: Colors.white.withValues(alpha: 0.18),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .moveY(begin: 0, end: -20, duration: 1800.ms)
                  .fadeIn(),
            ),
            Positioned(
              bottom: 60,
              right: 30,
              child:
              Icon(
                Icons.favorite,
                size: 32,
                color: Colors.white.withValues(alpha: 0.14),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .moveY(begin: 0, end: 25, duration: 2100.ms)
                  .fadeIn(),
            ),

            /// Header Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Profile Image
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage(imgUrl),
                          )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .scale(
                            duration: 900.ms,
                            curve: Curves.easeOutBack,
                          ),

                          /// Online Indicator
                          if (isOnline)
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child:
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.greenAccent,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms)
                                  .scale(duration: 600.ms),
                            ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      /// Name + Location + Tagline
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Name + Age + Crown
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "$userName, $age",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (isPremium)
                                    Icon(
                                      FontAwesomeIcons.crown,
                                      color: Colors.amber.shade300,
                                      size: 18,
                                    )
                                        .animate()
                                        .scale(duration: 700.ms)
                                        .fadeIn(),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16.sp,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "Lives in $location",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withValues(alpha: 0.95),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              if (tagline.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  tagline,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ).animate().fadeIn(duration: 600.ms),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(Icons.favorite_rounded, likes, "Likes"),
                      _StatItem(
                        Icons.people_alt_rounded,
                        matches,
                        "Matches",
                      ),
                      _StatItem(
                        Icons.remove_red_eye_rounded,
                        views,
                        "Views",
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 14),

                  /// Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const _ActionButton(Icons.favorite_rounded, "Like"),
                      const _ActionButton(Icons.share_rounded, "Share"),

                      if (!isPremium)
                        CustomGradientButton(
                          text: "Upgrade",
                          textColor: AppColors.primaryColor,
                          backgroundColor: Colors.white,
                          isBold: true,
                          onPressed: () {},
                        ).animate().fadeIn().scale(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------ STAT ITEM ------------
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem(this.icon, this.value, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.85),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

/// ------------ ACTION BUTTON ------------
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white.withValues(alpha: 0.1),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withValues(alpha: 0.20),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

/// ------------ CURVED CLIPPER ------------
class InwardArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + 40,
        size.width,
        size.height - 40,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
