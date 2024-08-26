import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:joistic_assignment/pages/home_page.dart';
import 'package:joistic_assignment/pages/login_page.dart';
import 'package:joistic_assignment/repo/auth_repo.dart';
import 'package:joistic_assignment/storage/storage_service.dart';
import 'package:joistic_assignment/utils/keys.dart';

class AuthenticationController extends GetxController {
  User? user;
  final AuthRepo _authRepo = AuthRepo();
  bool isLoading = false;
  final StorageService storageService = Get.find<StorageService>();
  Future signInWithGoogle() async {
    isLoading = true;
    update();
    try {
      user = await _authRepo.signInWithGoogle();
      if (user != null) {
        isLoading = false;
        update();
        saveUserDetails();
        return;
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      EasyLoading.showError('Sign in failed');
    }
  }

  Future signOut() async {
    isLoading = true;
    update();
    try {
      final result = await _authRepo.signOut();
      if (result) {
        clearUser();
        EasyLoading.showSuccess('Sign out successfully');
        isLoading = false;
        user = null;
        update();
        Get.to(const LoginPage());
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      EasyLoading.showError('Sign out failed');
    }
  }

  void saveUserDetails() {
    if (user != null) {
      storageService.write(Keys.email, user!.email);
      storageService.write(Keys.name, user!.displayName);
      storageService.write(Keys.photoUrl, user!.photoURL);
      storageService.write(Keys.isLogin, true);
      Get.to(HomePage(), popGesture: false);
    }
  }

  //Clear the user details from the storage
  void clearUser() {
    storageService.write(Keys.email, null);
    storageService.write(Keys.name, null);
    storageService.write(Keys.photoUrl, null);
    storageService.write(Keys.isLogin, false);
  }
}
