import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/screens/home/widgets/header_widget.dart';
import 'package:rishta_app/screens/home/widgets/matched_member_list.dart';
import '../../core/constants/color/app_color.dart';
import '../../global_widgets/PrimaryWidgets/app_bar.dart';
import '../../global_widgets/custom_drawer/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Setting",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(
                imgUrl: 'assets/dp_default.png',
                userName: 'Sophia',
                age: 26,
                location: 'Lahore, Pakistan',
                isPremium: false,
                isOnline: true,
                tagline: "Looking for meaningful connections",
                likes: "120",
                matches: "85",
                views: "2.3k",
              ),
              MatchedMemberList(
                listName: 'Suggested Matches',
                listDescription:
                    'Meeting the most compatible match for your profile',
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 10),
              MatchedMemberList(
                listName: 'Premium Matches',
                listDescription: 'Members who joined recently',
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 10),
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: AppColors.primaryColor,
              //     borderRadius: BorderRadius.circular(12),
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.black.withOpacity(0.5),
              //         blurRadius: 8,
              //         offset: const Offset(0, 2),
              //       )
              //     ],
              //   ),
              //   child: Stack(
              //     children: [
              //       // main content
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Image.asset(
              //             'assets/vip.png',
              //             color: Colors.white,
              //             height: 100,
              //           ),
              //
              //           const SizedBox(height: 2),
              //
              //           Row(
              //             children: const [
              //               Expanded(child: Divider(thickness: 1)),
              //               SizedBox(width: 1),
              //               Text(
              //                 'Starting from',
              //                 style: TextStyle(fontSize: 14, color: Colors.white),
              //               ),
              //               SizedBox(width: 8),
              //               Expanded(child: Divider(thickness: 1)),
              //             ],
              //           ),
              //
              //           const SizedBox(height: 8),
              //
              //           const Text(
              //             'PKR 0',
              //             style: TextStyle(
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //             ),
              //           ),
              //
              //           const SizedBox(height: 16),
              //
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               _buildTickWithText('Top consultant', Colors.white),
              //               const SizedBox(height: 8),
              //               _buildTickWithText('Assured Meeting with handpicked Matches', Colors.white),
              //               const SizedBox(height: 8),
              //               _buildTickWithText('100% discrete & Private', Colors.white),
              //               const SizedBox(height: 8),
              //               _buildTickWithText('50000+ Satisfied VIPs', Colors.white),
              //             ],
              //           ),
              //         ],
              //       ),
              //       Positioned(
              //         top: 0,
              //         right: 0,
              //         child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => AssistedScreen(),
              //               ),
              //             );
              //           },
              //           child: const Icon(
              //             Icons.arrow_forward_ios,
              //             color: Colors.white,
              //             size: 20,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
