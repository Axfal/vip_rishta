import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rishta_app/services/user_session.dart';
import 'package:rishta_app/core/route/routes_name.dart';

import '../bloc/match/match_bloc.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    SessionController()
        .getUserFromPreference()
        .then((value) async {
          if (SessionController.isLogin) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<MatchBloc>().add(SuggestedMatchEvent());
            });
            Timer(
              const Duration(seconds: 5),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.home,
                (route) => false,
              ),
            );
          } else {
            Timer(
              const Duration(seconds: 5),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.login,
                (route) => false,
              ),
            );
          }
        })
        .onError((error, stackTrace) {
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.login,
              (route) => false,
            ),
          );
        });
  }
}
