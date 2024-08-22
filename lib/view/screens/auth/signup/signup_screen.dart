import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/auth_controller.dart';
import '../../../utils/colors/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_redirect.dart';
import '../../../widgets/custom_textfield.dart';
import '../login/login_screen.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final RxBool isTermsAccepted = false.obs;

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Name',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: isTermsAccepted.value,
                        onChanged: (value) {
                          isTermsAccepted.value = value ?? false;
                        },
                      )),
                      const Expanded(
                        child: Text(
                          'I accept the Terms and Conditions',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (isTermsAccepted.value) {
                          authController.signup(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          Get.snackbar("Success", "Signup successful!",
                              backgroundColor: AppColors.primaryColor,
                              colorText: Colors.white);
                        } else {
                          Get.snackbar(
                              "Error", "Please accept the terms and conditions",
                              backgroundColor: AppColors.primaryColor,
                              colorText: Colors.white);
                        }
                      }
                    },
                  ),
                  CustomRedirect(
                    message: 'Already have an account? ',
                    linkText: 'Sign In',
                    Navigate: LoginPage(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}




