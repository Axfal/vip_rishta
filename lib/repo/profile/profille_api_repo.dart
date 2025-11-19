import 'dart:io';

abstract class ProfileApiRepo {
  Future<dynamic> getProfile(dynamic data);
  Future<dynamic> updateProfile(dynamic data, File? image);
}
