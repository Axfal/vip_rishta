import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/color/app_color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Match Found!",
      "message": "A new match aligns with your preferences. Check it now!",
      "time": "2m",
      "icon": FontAwesomeIcons.heart,
      "unread": true,
    },
    {
      "title": "Profile Viewed",
      "message": "Someone viewed your profile.",
      "time": "10m",
      "icon": FontAwesomeIcons.eye,
      "unread": true,
    },
    {
      "title": "New Message",
      "message": "Ayesha sent you a new message.",
      "time": "1h",
      "icon": FontAwesomeIcons.solidCommentDots,
      "unread": false,
    },
    {
      "title": "Suggestions Updated",
      "message": "Your match suggestions are refreshed.",
      "time": "Yesterday",
      "icon": FontAwesomeIcons.sliders,
      "unread": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: notifications.isEmpty
          ? _emptyState()
          : ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _notificationTile(notifications[index]);
        },
      ),
    );
  }

  // EMPTY STATE
  Widget _emptyState() {
    return Center(
      child: Text(
        "No Notifications Yet",
        style: GoogleFonts.poppins(
          fontSize: 17.sp,
          color: Colors.black38,
        ),
      ),
    );
  }

  // NOTIFICATION TILE — Instagram-Style
  Widget _notificationTile(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON BUBBLE — soft look
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                item["icon"],
                color: AppColors.primaryColor,
                size: 20.sp,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + unread dot
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item["title"],
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    if (item["unread"])
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      )
                  ],
                ),

                SizedBox(height: 5.h),

                Text(
                  item["message"],
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  item["time"],
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
