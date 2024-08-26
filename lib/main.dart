import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:joistic_assignment/pages/home_page.dart';
import 'package:joistic_assignment/pages/login_page.dart';
import 'package:joistic_assignment/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  final isLogin = Get.find<StorageService>().read('isLogin') as bool?;
  runApp(MyApp(
    isLogin: isLogin ?? false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLogin ? const HomePage() : const LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
