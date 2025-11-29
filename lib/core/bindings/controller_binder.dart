import 'package:dermaininstitute/core/utils/manager/network_manager.dart';
import 'package:get/get.dart';
import 'package:dermaininstitute/features/common/authentication/forgot_password/controllers/forgot_password_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/home/controllers/home_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Initialize NetworkManager as a singleton
    Get.put(NetworkManager(), permanent: true);
    // Register ForgotPasswordController for global access
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    // Register HomeController for global access
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
