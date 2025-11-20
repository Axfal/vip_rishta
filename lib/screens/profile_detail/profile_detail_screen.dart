import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  bool isPremiumUser = false;
  bool isLiked = false;
  bool isRequestSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            _topImageHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      _headerInfo().animate().fadeIn(duration: 500.ms),
                      25.verticalSpace,

                      _actionButtons().animate().slideY(begin: 0.3).fade(),

                      25.verticalSpace,
                      _sectionTitle("Basic Information"),
                      _buildBasicInfo(),

                      20.verticalSpace,
                      _sectionTitle("Education"),
                      isPremiumUser
                          ? _premiumUnlockWidget(false)
                          : _premiumUnlockWidget(true),

                      20.verticalSpace,
                      _sectionTitle("Professional Info"),
                      isPremiumUser
                          ? _premiumUnlockWidget(false)
                          : _premiumUnlockWidget(true),

                      40.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------
  // TOP IMAGE HEADER
  // -------------------------------------------

  Widget _topImageHeader() {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            height: 300.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 15,
            left: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Online Badge
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "● Online",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------
  // PROFILE BASIC HEADER
  // -------------------------------------------

  Widget _headerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ayesha Khan, 23",
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        5.verticalSpace,
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.grey),
            5.horizontalSpace,
            Text(
              "Lahore, Pakistan",
              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  // -------------------------------------------
  // ACTION BUTTONS (LIKE + CONNECT)
  // -------------------------------------------

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.pinkAccent),
                color: isLiked ? Colors.pink.shade50 : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLiked
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: Colors.pinkAccent,
                    size: 18,
                  ),
                  10.horizontalSpace,
                  Text(
                    isLiked ? "Liked" : "Like",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        12.horizontalSpace,

        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isRequestSent = !isRequestSent;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: isRequestSent
                    ? Colors.green.shade600
                    : Colors.blue.shade600,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  isRequestSent ? "Requested" : "Connect",
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------
  // SECTION TITLE
  // -------------------------------------------

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
    );
  }

  // -------------------------------------------
  // BASIC INFO (FREE USERS CAN SEE)
  // -------------------------------------------

  Widget _buildBasicInfo() {
    return Column(
      children: [
        _infoTile("Religion", "Islam"),
        _infoTile("Community", "Awan"),
        _infoTile("Height", "5ft 4in"),
        _infoTile("Marital Status", "Single"),
      ],
    );
  }

  Widget _infoTile(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 15.sp)),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------
  // PREMIUM-LOCKED SECTIONS
  // -------------------------------------------

  Widget _premiumUnlockWidget(bool locked) {
    if (!locked) {
      return Column(
        children: [
          _infoTile("Qualification", "BSCS (GCU Lahore)"),
          _infoTile("Field of Study", "Computer Science"),
          _infoTile("Job", "Flutter Developer"),
          _infoTile("Income", "Rs 120,000"),
        ],
      );
    }

    // LOCKED SECTION → FREE USER
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _lockedRow("Qualification"),
                _lockedRow("Job"),
                _lockedRow("Income"),
                _lockedRow("Work Location"),
              ],
            ),
          ).blurred(blur: 3, colorOpacity: 0.03),

          Positioned.fill(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.pink.shade600,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  "Upgrade to Premium",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedRow(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          Icon(Icons.lock, size: 18, color: Colors.grey),
          10.horizontalSpace,
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
