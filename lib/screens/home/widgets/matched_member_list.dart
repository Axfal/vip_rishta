import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/screens/home/widgets/all_cards_page.dart';
import 'package:rishta_app/screens/home/widgets/profile_card.dart';

class MatchedMemberList extends StatelessWidget {
  final String listName;
  final String listDescription;
  final Color color;

  const MatchedMemberList({
    super.key,
    required this.listName,
    required this.listDescription,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final members = [
      {
        "image":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80",
        "name": "Ayesha",
        "age": 20,
        "height": "5'4",
        "language": "Urdu, Muslim",
        "location": "Lahore, Pakistan",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1722354980566-ec247cb4f1a8?q=80&w=627&auto=format&fit=crop",
        "name": "Ali",
        "age": 22,
        "height": "5'6",
        "language": "Punjabi, Sunni",
        "location": "Karachi, Pakistan",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80",
        "name": "Hina",
        "age": 23,
        "height": "5'5",
        "language": "Urdu, Sunni",
        "location": "Islamabad, Pakistan",
      },
      {
        "image":
            "https://images.unsplash.com/photo-1722354980566-ec247cb4f1a8?q=80&w=627&auto=format&fit=crop",
        "name": "Umer",
        "age": 20,
        "height": "5'4",
        "language": "Urdu, Muslim",
        "location": "Lahore, Pakistan",
      },
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ------------------ Title ------------------
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listName,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    listDescription,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Gradient Underline
                  Container(
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppColors.Linear_gradient,
                    ),
                  ),
                ],
              )
              .animate()
              .fade(duration: 500.ms)
              .moveY(begin: 12, end: 0, duration: 600.ms),

          const SizedBox(height: 14),

          /// ------------------ Horizontal Cards ------------------
          SizedBox(
            height: 226,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final m = members[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child:
                      ProfileCard(
                            imagePath: m["image"] as String,
                            name: m["name"]! as String,
                            age: m["age"]! as int,
                            height: m["height"]! as String,
                            language: m["language"]! as String,
                            location: m["location"]! as String,
                          )
                          .animate()
                          .fade(duration: 600.ms)
                          .scale(
                            begin: const Offset(0.95, 0.95),
                            end: const Offset(1, 1),
                            duration: 500.ms,
                          )
                          .moveX(begin: 20, end: 0),
                );
              },
            ),
          ),

          const SizedBox(height: 6),

          Divider(color: Colors.black12, height: 28),

          /// ------------------ SEE ALL Button ------------------
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AllCardsPage(title: listName),
                  ),
                );
              },
              child: Text(
                "See all",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  foreground: Paint()
                    ..shader = AppColors.Linear_gradient.createShader(
                      const Rect.fromLTWH(0, 0, 200, 20),
                    ),
                ),
              ),
            ).animate().fade(duration: 600.ms).moveY(begin: 10, end: 0),
          ),
        ],
      ),
    );
  }
}
