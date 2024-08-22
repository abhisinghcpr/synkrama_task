import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/auth_controller.dart';
import '../../../utils/colors/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_redirect.dart';
import '../../../widgets/custom_textfield.dart';
import '../../dashboard/home_widgets/dashboard.dart';
import '../signup/signup_screen.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(

        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Login ',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.primaryColor,fontWeight:
              FontWeight.w900

          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'Login to Your Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
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
                        return 'Password must be at least 6 char long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final result = await authController.login(
                          emailController.text,
                          passwordController.text,
                        );

                        if (result) {
                          Get.snackbar(
                            "Success",
                            "Login successful!",
                            backgroundColor: AppColors.primaryColor,
                            colorText: Colors.white,
                          );
                          Get.offAll(() => DashboardView());
                        } else {
                          Get.snackbar(
                            "Error",
                            "Invalid email or password",
                            backgroundColor: AppColors.primaryColor,
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {

                      },
                      child: const Text("Forgot Password?",style: TextStyle(color: AppColors.primaryColor),),
                    ),
                  ),
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or Continue with",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22,
                        backgroundImage: AssetImage('assets/images/google.png'),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22,
                        backgroundImage: AssetImage('assets/images/facebook.png'),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22,
                        backgroundImage: AssetImage('assets/images/twitter.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomRedirect(
                    message: 'Create an account? ',
                    linkText: 'Sign Up',
                    Navigate: SignupPage(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
