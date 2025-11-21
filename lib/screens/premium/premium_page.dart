import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final List<Map<String, dynamic>> dummyPlans = [
    {
      "name": "Basic",
      "price": 799,
      "duration": "1 Month",
      "features": [
        "View unlimited profiles",
        "Send 10 contact requests",
        "Basic chat access",
      ],
    },
    {
      "name": "Standard",
      "price": 1299,
      "duration": "3 Months",
      "recommended": true,
      "features": [
        "Unlimited chats",
        "Contact requests: 30",
        "See who viewed your profile",
        "Use incognito mode",
      ],
    },
    {
      "name": "Premium",
      "price": 1999,
      "duration": "6 Months",
      "features": [
        "Unlimited chat & contacts",
        "Profile boost weekly",
        "See visitors",
        "Verified badge",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Premium Plans",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            _headerSection(),
            12.h.verticalSpace,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                itemCount: dummyPlans.length,
                itemBuilder: (context, index) {
                  final plan = dummyPlans[index];
                  return _planCard(plan).animate().fadeIn().scale();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------------------
  /// HEADER WITH GRADIENT + ICON
  /// ------------------------------
  Widget _headerSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 16.w),
      decoration: const BoxDecoration(gradient: AppColors.Linear_gradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.workspace_premium, color: Colors.white, size: 45.sp),
          8.h.verticalSpace,
          Text(
            "Upgrade to Premium",
            style: GoogleFonts.poppins(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.h.verticalSpace,
          Text(
            "Get more visibility & better matches.",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  /// ------------------------------
  /// PLAN CARD UI
  /// ------------------------------
  Widget _planCard(Map<String, dynamic> plan) {
    bool recommended = plan["recommended"] ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
        border: Border.all(
          color: recommended ? AppColors.primaryColor : Colors.grey.shade300,
          width: recommended ? 1.8 : 1,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Recommended badge
          if (recommended)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Recommended",
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ),

          10.h.verticalSpace,

          /// Plan title + price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan["name"],
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Text(
                "PKR ${plan["price"]}",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),

          4.h.verticalSpace,
          Text(
            plan["duration"],
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
          ),

          12.h.verticalSpace,

          /// Features
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (plan["features"] as List<dynamic>).map((feature) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 18,
                    ),
                    8.w.horizontalSpace,
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          16.h.verticalSpace,

          /// Button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                gradient: AppColors.Linear_gradient,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  "Get Premium",
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
