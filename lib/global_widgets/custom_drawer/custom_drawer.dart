import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/screens/dashboard/provider/provider.dart';
import 'package:rishta_app/screens/dashboard/dashboard_page.dart';
import 'package:rishta_app/screens/my_profile/my_profile.dart';
import 'package:rishta_app/screens/matches/matches_page.dart';
import 'package:rishta_app/screens/inbox/inbox_page.dart';
import 'package:rishta_app/partner_prefernces/partner_prefences.dart';
import 'package:rishta_app/screens/my_profile/widgets/help_and_support/help_and_support.dart';
import 'package:rishta_app/screens/setting/setting.dart';

import '../../screens/chats/chats_page.dart';
import '../../screens/notification/notification_screen.dart';
import '../../services/user_session.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _navigate(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FadeInDown(
        duration: const Duration(milliseconds: 400),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.red),
              SizedBox(width: 10.w),
              Text(
                "Confirm Logout",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                SessionController().logoutUser(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.Linear_gradient),
        child: Stack(
          children: [
            // Floating ambient hearts
            Positioned(
              top: 120,
              left: 50,
              child:
                  Icon(
                        Icons.favorite,
                        size: 30,
                        color: AppColors.white.withValues(alpha: 0.15),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: -12,
                        duration: 2200.ms,
                        curve: Curves.easeInOut,
                      ),
            ),
            Positioned(
              bottom: 180,
              right: 30,
              child:
                  Icon(
                        Icons.favorite,
                        size: 25,
                        color: AppColors.white.withValues(alpha: 0.12),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(
                        begin: 0,
                        end: 15,
                        duration: 2400.ms,
                        curve: Curves.easeInOut,
                      ),
            ),

            // Drawer content
            ListView(
              padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
              children: [
                // Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orangeAccent.withValues(alpha: 0.7),
                                Colors.deepOrange.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orangeAccent.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 38.r,
                            backgroundColor: Colors.white,
                            backgroundImage: const AssetImage(
                              'assets/dp_default.png',
                            ),
                          ),
                        )
                        .animate()
                        .fade(duration: 600.ms)
                        .scale(duration: 900.ms, curve: Curves.easeOutBack)
                        .slideY(begin: 0.2, end: 0, duration: 700.ms),

                    SizedBox(height: 12.h),
                    Text(
                      "Hi, Anfal",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ).animate().fade(duration: 800.ms).moveY(begin: 10, end: 0),
                    Text(
                      "anfalshah72@gmail.com",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Divider(color: Colors.white),
                SizedBox(height: 20.h),

                // Drawer Items
                _DrawerItem(
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  ),
                ),
                _DrawerItem(
                  icon: Icons.person_search_outlined,
                  title: 'Matches',
                  onTap: () {

                    _navigate(context, const MatchesPage());
                  },
                ),
                _DrawerItem(
                  icon: FontAwesomeIcons.message,
                  title: 'Chat',
                  onTap: () {
                    _navigate(context, const ChatsPage());
                  },
                ),
                _DrawerItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    _navigate(context, NotificationScreen());
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
                _DrawerItem(
                  icon: FontAwesomeIcons.signOut,
                  title: 'Logout',
                  onTap: () => _showLogoutDialog(context),
                ),

                SizedBox(height: 150.h),
                Center(
                  child: Text(
                    "© IT Genesis",
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 24.sp),
                    SizedBox(width: 16.w),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fade(duration: 600.ms)
              .moveX(begin: -20, end: 0, curve: Curves.easeOut),
    );
  }
}
