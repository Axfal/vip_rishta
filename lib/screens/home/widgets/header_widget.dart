import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/color/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeaderWidget extends StatelessWidget {
  final String imgUrl, userName, location, tagline, likes, matches, views;
  final bool isPremium, isOnline;

  const HeaderWidget({
    super.key,
    required this.imgUrl,
    required this.userName,
    required this.location,
    required this.likes,
    required this.matches,
    required this.views,
    this.tagline = '',
    this.isPremium = false,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return ClipPath(
      clipper: InwardArchClipper(),
      child: Container(
        height: h * 0.259,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: AppColors.Linear_gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Floating hearts
            Positioned(
              top: 30,
              left: 30,
              child: AnimatedHeart(size: 26, alpha: .18, dy: -18),
            ),
            Positioned(
              bottom: 40,
              right: 30,
              child: AnimatedHeart(size: 32, alpha: .14, dy: 22),
            ),

            Column(
              children: [
                Row(
                  children: [
                    // Profile Picture + Online Dot
                    Stack(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imgUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,

                            // Placeholder
                            placeholder: (context, url) => const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),

                            // Error Image
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.error, color: Colors.white),
                                ),
                          ),
                        ).animate().fadeIn().scale(curve: Curves.easeOutBack),

                        if (isOnline)
                          Positioned(bottom: 4, right: 4, child: OnlineDot()),
                      ],
                    ),

                    const SizedBox(width: 10),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  userName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (isPremium)
                                Icon(
                                  FontAwesomeIcons.crown,
                                  color: Colors.amber.shade300,
                                  size: 18,
                                ).animate().scale(),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "Lives in $location",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.white.withOpacity(.9),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (tagline.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                tagline,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ).animate().fadeIn(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItem(Icons.favorite_rounded, likes, "Likes"),
                    StatItem(Icons.people_alt_rounded, matches, "Matches"),
                    StatItem(Icons.remove_red_eye_rounded, views, "Views"),
                  ],
                ).animate().fadeIn().slideY(begin: .3),

                const SizedBox(height: 10),

                // if (!isPremium)
                //   CustomGradientButton(
                //     text: "Upgrade",
                //     textColor: AppColors.primaryColor,
                //     backgroundColor: Colors.white,
                //     isBold: true,
                //     onPressed: () =>
                //         Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumPage())),
                //   ).animate().fadeIn().scale()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ------ SMALLER COMPONENTS ---------

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value, label;

  const StatItem(this.icon, this.value, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionBtn(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white.withOpacity(.1),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withOpacity(.2),
                child: Icon(icon, size: 18, color: Colors.white),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class OnlineDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    ).animate().fadeIn().scale();
  }
}

class AnimatedHeart extends StatelessWidget {
  final double size, alpha, dy;

  const AnimatedHeart({
    required this.size,
    required this.alpha,
    required this.dy,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
          Icons.favorite,
          size: size,
          color: Colors.white.withOpacity(alpha),
        )
        .animate(onPlay: (c) => c.repeat())
        .moveY(begin: 0, end: dy, duration: 1800.ms)
        .fadeIn();
  }
}

/// ------------ CURVED CLIPPER ------------
class InwardArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 30)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + 30,
        size.width,
        size.height - 30,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> old) => false;
}
