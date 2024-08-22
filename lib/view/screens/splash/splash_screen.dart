import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../utils/colors/app_color.dart';
import '../auth/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    Future.delayed(Duration(seconds: 2), () async {
      await authController.checkLoginStatus();
    });

    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundColor: AppColors.primaryColor,
          child: Text(
            "Synkrama",
            style: TextStyle(color: AppColors.white, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
