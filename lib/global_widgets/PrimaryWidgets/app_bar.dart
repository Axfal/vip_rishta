import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  // 💡 Set your custom height here
  final double customHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.customHeight = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.Linear_gradient,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.12),
        //     blurRadius: 20,
        //     offset: const Offset(0, 6),
        //   ),
        // ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 12,
            right: 22,
            child:
                Icon(
                      Icons.favorite,
                      size: 22,
                      color: AppColors.white.withValues(alpha: 0.18),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .moveY(begin: 0, end: -10, duration: 1800.ms)
                    .fadeIn(duration: 700.ms),
          ),

          /// Main AppBar Row
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Row(
                    children:
                        actions ??
                        [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✔ AppBar height override
  @override
  Size get preferredSize => Size.fromHeight(customHeight);
}
