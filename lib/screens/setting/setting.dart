import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/color/app_color.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool pushNotifications = true;
  bool newsletterSubscription = false;
  String selectedLanguage = 'English';
  String selectedTheme = 'System Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black,
          ),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Preferences Section
                _sectionTitle("App Preferences"),
                SizedBox(height: 8.h),
                _settingsCard(
                  children: [
                    _buildDropdownField(
                      "Language",
                      selectedLanguage,
                      ['English', 'Urdu', 'Spanish'],
                      (val) {
                        setState(() => selectedLanguage = val!);
                      },
                    ),
                    _buildDropdownField(
                      "Theme",
                      selectedTheme,
                      ['Light', 'Dark', 'System Default'],
                      (val) {
                        setState(() => selectedTheme = val!);
                      },
                    ),
                    _buildSwitchField("Push Notifications", pushNotifications, (
                      val,
                    ) {
                      setState(() => pushNotifications = val);
                    }),
                    _buildSwitchField(
                      "Newsletter Subscription",
                      newsletterSubscription,
                      (val) {
                        setState(() => newsletterSubscription = val);
                      },
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Support & Legal Section
                _sectionTitle("Support & Legal"),
                SizedBox(height: 8.h),
                _settingsCard(
                  children: [
                    _buildTile(
                      "Help & Support",
                      FontAwesomeIcons.headset,
                      () {},
                    ),
                    _buildTile(
                      "Privacy Policy",
                      FontAwesomeIcons.shieldAlt,
                      () {},
                    ),
                    _buildTile(
                      "Terms & Conditions",
                      FontAwesomeIcons.fileContract,
                      () {},
                    ),
                    _buildTile("About App", FontAwesomeIcons.infoCircle, () {
                      showAboutDialog(
                        context: context,
                        applicationName: "Tasty Bites",
                        applicationVersion: "v1.0.0",
                        applicationIcon: Icon(
                          FontAwesomeIcons.utensils,
                          color: AppColors.primaryColor,
                        ),
                        children: [Text("Developed by Your Company")],
                      );
                    }),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section Title
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    ).animate().fade(duration: 500.ms);
  }

  // Card container for settings fields
  Widget _settingsCard({required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      elevation: 3,
      shadowColor: Colors.black26,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: children
              .map(
                (child) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: child
                      .animate()
                      .fade(duration: 400.ms)
                      .slideX(begin: 0.1, end: 0, duration: 400.ms),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // ListTile for navigation items
  Widget _buildTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }

  // Switch field using flutter_switch
  Widget _buildSwitchField(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        FlutterSwitch(
          width: 55.w,
          height: 28.h,
          valueFontSize: 12.sp,
          toggleSize: 22.sp,
          value: value,
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.grey.shade300,
          toggleColor: Colors.white,
          onToggle: onChanged,
        ),
      ],
    );
  }

  // Dropdown field
  Widget _buildDropdownField(
    String title,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        DropdownButton<String>(
          value: value,
          items: options
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          underline: SizedBox(),
        ),
      ],
    );
  }
}
