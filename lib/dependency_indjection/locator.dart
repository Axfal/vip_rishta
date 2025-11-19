import 'package:get_it/get_it.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';
import 'package:rishta_app/repo/auth/auth_http_api_repo.dart';
import 'package:rishta_app/repo/profile/profile_http_api_repo.dart';
import 'package:rishta_app/repo/profile/profille_api_repo.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<AuthApiRepo>(() => AuthHttpApiRepo());
    getIt.registerLazySingleton<ProfileApiRepo>(() => ProfileHttpApiRepo());
  }
}
