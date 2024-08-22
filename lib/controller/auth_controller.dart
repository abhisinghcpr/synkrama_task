import 'package:get/get.dart';
import 'package:synkrama_task/view/screens/auth/login/login_screen.dart';
import '../model/user_model.dart';
import '../view/screens/dashboard/home_widgets/dashboard.dart';
import 'db_helper.dart';
import 'localstorage_services.dart';

class AuthController extends GetxController {
  var authService = DbHelper();
  var isLoggedIn = false.obs;
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    authService.initDb();

  }

  Future<void> checkLoginStatus() async {
    String? userEmail = await LocalStorageService.getUserSession();
    if (userEmail != null) {
      isLoggedIn.value = true;
      user.value = await authService.getUserByEmail(userEmail);
      Get.offAll(() => DashboardView());
    } else {
      isLoggedIn.value = false;
      Get.offAll(() => LoginPage());
    }
  }

  Future<bool> login(String email, String password) async {
    var user = await authService.loginUser(email, password);
    if (user != null) {
      await LocalStorageService.saveUserSession(email);
      this.user.value = user;
      return true;
    } else {
      return false;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    var newUser = UserModel(name: name, email: email, password: password);
    await authService.registerUser(newUser);
    await LocalStorageService.saveUserSession(email);
    this.user.value = newUser;
    Get.offAll(() => DashboardView());
  }

  Future<void> logout() async {
    await LocalStorageService.clearUserSession();
    user.value = null;
    Get.offAll(() => LoginPage());
  }

  Future<void> updateUserName(String newName) async {
    String? email = await LocalStorageService.getUserSession();
    if (email != null) {
      await authService.updateUserName(email, newName);
      var updatedUser = await authService.getUserByEmail(email);
      user.value = updatedUser;
    }
  }
}
