import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rishta_app/bloc/profile/profile_bloc.dart';
import 'core/route/routes.dart';
import 'core/route/routes_name.dart';
import 'dependency_indjection/locator.dart';
import 'bloc/match/match_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MatchBloc>(
          create: (_) => MatchBloc(activityApiRepo: getIt()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(profileApiRepo: getIt()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pakay Rishtay',
            themeMode: ThemeMode.dark,
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
