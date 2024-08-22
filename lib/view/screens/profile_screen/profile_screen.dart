import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synkrama_task/controller/auth_controller.dart';
import 'package:synkrama_task/view/utils/colors/app_color.dart';
import '../../../model/user_model.dart';
import '../../widgets/custom_button.dart';
import '../auth/login/login_screen.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = _authController.user.value;
        if (user == null) {
          return Center(child: Text('No user data available.'));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(user),
              _buildInfoSection(user, context),
              _buildActionButtons(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(UserModel user) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_images.jpeg'),
            ),
            SizedBox(height: 10),
            Text(
              user.name ?? "",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(UserModel user, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoTile(Icons.email, 'Email', user.email),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueAccent),
            title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(user.name ?? ""),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: () => _showUpdateNameBottomSheet(context, user),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateNameBottomSheet(BuildContext context, UserModel user) {
    final TextEditingController _nameController =
        TextEditingController(text: user.name);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: "Enter new name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  onPressed: () async {
                    await _authController.updateUserName(_nameController.text);
                    Get.back();
                    Get.snackbar('Success', 'Name updated successfully!',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white);
                  },
                  text: 'Update',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 50),
          OutlinedButton(
            onPressed: () => _showLogoutConfirmationDialog(context),
            child: Text('Logout'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blueAccent),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await _authController.logout();
                Get.back();
                Get.offAll(() => LoginPage());
                Get.snackbar(
                    'Logged Out', 'You have been logged out successfully!',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: AppColors.primaryColor,
                    colorText: Colors.white);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
