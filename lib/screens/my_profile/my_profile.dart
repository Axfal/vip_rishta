import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/screens/my_profile/widgets/basic-info/basic_info.dart';
import 'package:rishta_app/screens/my_profile/widgets/family/family.dart';
import 'package:rishta_app/screens/my_profile/widgets/hobbies_interest/hobbies_interest.dart';
import 'package:rishta_app/screens/my_profile/widgets/lifestyle/lifestyle.dart';
import 'package:rishta_app/screens/my_profile/widgets/location_education_career/location_education_career.dart';
import 'package:rishta_app/screens/my_profile/widgets/more_about/more_about.dart';
import 'package:rishta_app/screens/my_profile/widgets/more_religion_details/more_religion_details.dart';
import 'package:rishta_app/screens/my_profile/widgets/partner_basic_info/partner_basic_info.dart';
import 'package:rishta_app/screens/my_profile/widgets/partner_education_career/partner_education_career.dart';
import 'package:rishta_app/screens/my_profile/widgets/partner_location_detail/partner_location_detail.dart';
import 'package:rishta_app/screens/my_profile/widgets/partner_other_detail/partner_other_detail.dart';
import 'package:rishta_app/screens/my_profile/widgets/religious_background/religious_background.dart';
import 'package:rishta_app/screens/my_profile/widgets/upload_profile_image/upload_profile_image.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: []
        ),
      ),
    );

  }
}
