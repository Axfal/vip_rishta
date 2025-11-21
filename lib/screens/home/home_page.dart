import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rishta_app/bloc/match/match_bloc.dart';
import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/response/status.dart';
import 'package:rishta_app/model/match/match_model.dart';
import 'package:rishta_app/screens/home/widgets/header_widget.dart';
import 'package:rishta_app/screens/matches/matches_page.dart';
import '../../core/constants/color/app_color.dart';
import '../../global_widgets/custom_drawer/custom_drawer.dart';
import '../profile_detail/profile_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<MatchBloc>().add(SuggestedMatchEvent());
  //   });
  // }

  final List<Map<String, dynamic>> matches = [
    {
      "name": "Ayesha",
      "age": 22,
      "city": "Lahore",
      "caste": "Rajput",
      "profession": "Software Engineer",
      "image":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80",
      "premium": false,
    },
    {
      "name": "Ali Raza",
      "age": 25,
      "city": "Karachi",
      "caste": "Syed",
      "profession": "Doctor",
      "image":
          "https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
    {
      "name": "Hina",
      "age": 23,
      "city": "Islamabad",
      "caste": "Malik",
      "profession": "Teacher",
      "image":
          "https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
    {
      "name": "Ayesha",
      "age": 22,
      "city": "Lahore",
      "caste": "Rajput",
      "profession": "Software Engineer",
      "image":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80",
      "premium": false,
    },
    {
      "name": "Ali Raza",
      "age": 25,
      "city": "Karachi",
      "caste": "Syed",
      "profession": "Doctor",
      "image":
          "https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
    {
      "name": "Hina",
      "age": 23,
      "city": "Islamabad",
      "caste": "Malik",
      "profession": "Teacher",
      "image":
          "https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
    {
      "name": "Ayesha",
      "age": 22,
      "city": "Lahore",
      "caste": "Rajput",
      "profession": "Software Engineer",
      "image":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80",
      "premium": false,
    },
    {
      "name": "Ali Raza",
      "age": 25,
      "city": "Karachi",
      "caste": "Syed",
      "profession": "Doctor",
      "image":
          "https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
    {
      "name": "Hina",
      "age": 23,
      "city": "Islamabad",
      "caste": "Malik",
      "profession": "Teacher",
      "image":
          "https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=800&q=80",
      "premium": true,
    },
  ];

  // ------------------ OPEN PREFERENCES POPUP --------------------
  void _openPreferencesDialog() {
    TextEditingController minAge = TextEditingController();
    TextEditingController maxAge = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController education = TextEditingController();
    TextEditingController job = TextEditingController();
    TextEditingController religion = TextEditingController();
    TextEditingController status = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Filters",
      transitionBuilder: (context, anim1, anim2, widget) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(opacity: anim1.value, child: widget),
        );
      },
      pageBuilder: (context, _, __) {
        return Center(
          child: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 340,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withValues(alpha: 0.92),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TITLE
                          Center(
                            child: Text(
                              "Partner Preferences",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                          _sectionTitle("Age Range"),

                          Row(
                            children: [
                              Expanded(
                                child: _inputBox(
                                  "Min Age",
                                  minAge,
                                  Icons.child_care,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _inputBox(
                                  "Max Age",
                                  maxAge,
                                  Icons.group,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),
                          _sectionTitle("Location"),
                          _inputBox("Preferred City", city, Icons.location_on),

                          const SizedBox(height: 18),
                          _sectionTitle("Education"),
                          _inputBox(
                            "Preferred Education",
                            education,
                            Icons.school,
                          ),

                          const SizedBox(height: 18),
                          _sectionTitle("Profession"),
                          _inputBox("Preferred Job", job, Icons.work),

                          const SizedBox(height: 18),
                          _sectionTitle("Religion"),
                          _inputBox(
                            "Preferred Religion",
                            religion,
                            Icons.mosque,
                          ),

                          const SizedBox(height: 18),
                          _sectionTitle("Marital Status"),
                          _inputBox("Marital Status", status, Icons.favorite),

                          const SizedBox(height: 28),

                          // APPLY BUTTON
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 55,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // TODO: API CALL HERE
                                },
                                child: Text(
                                  "Apply",
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ).animate().scale(duration: 350.ms),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  final bool isPremiumUser = false;

  Widget _inputBox(
    String hint,
    TextEditingController controller,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20, color: Colors.grey[600]),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 14),
      ),
    );
  }

  Widget _partnerCard(MatchModel match, int index) {
    final m = match.results[index];
    bool isLocked = m.isPremium == true;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailScreen(matchResult: m),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        height: 480.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // ------------------- IMAGE -------------------
              Positioned.fill(
                child: Image.network(
                  '${APIUrls.baseUrl}/${m.image}',
                  fit: BoxFit.cover,
                  color: isLocked ? Colors.black.withValues(alpha: 0.55) : null,
                  colorBlendMode: isLocked
                      ? BlendMode.darken
                      : BlendMode.srcOver,

                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    );
                  },
                ),
              ),

              // ------------------- BLUR WHEN LOCKED -------------------
              if (isLocked)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(color: Colors.transparent),
                  ),
                ),

              // ------------------- GRADIENT -------------------
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.85),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // ------------------- PROFILE DETAILS -------------------
              Positioned(
                bottom: 20,
                left: 18,
                right: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${m.firstName} ${m.lastName}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${m.age} yrs • ${m.city} • ${m.community}",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${m.job}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

              if (isLocked)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.lock,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 350.ms).slide(begin: const Offset(0, 0.2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pakay Rishtay",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.filter, color: Colors.black),
            onPressed: _openPreferencesDialog,
          ),
        ],
      ),
      body: SafeArea(
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
            SizedBox(height: 20.h),
            Expanded(
              child: BlocConsumer<MatchBloc, MatchState>(
                listenWhen: (previous, current) =>
                    previous.apiResponse.status != current.apiResponse.status,
                listener: (context, state) {
                  // You can show snackbars or logs here if needed.
                  if (state.apiResponse.status == Status.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.apiResponse.message ?? "Error"),
                      ),
                    );
                  }
                },

                builder: (context, state) {
                  if (state.apiResponse.status == Status.loading) {
                    return const Center(
                      child: CupertinoActivityIndicator(color: Colors.black54),
                    );
                  }

                  if (state.apiResponse.status == Status.error) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 40),
                    );
                  }

                  // Success UI
                  return CarouselSlider.builder(
                    itemCount: state.matchModel.results.length,
                    options: CarouselOptions(
                      height: 400.h,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.98,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return _partnerCard(state.matchModel, index);
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                  /// Left Divider
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withValues(alpha: 0.35),
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MatchesPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        "See All",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  /// Right Divider
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withValues(alpha: 0.35),
                    ),
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
