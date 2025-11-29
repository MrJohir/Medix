import 'package:dermaininstitute/features/common/authentication/login/controller/login_controller.dart';
import 'package:dermaininstitute/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class DermaInstitute extends StatelessWidget {
  DermaInstitute({super.key});

  /////logincontroller you can find from anywhere
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final String? token = box.read('authToken');
    final String role = (box.read('userRole') ?? '')
        .toString()
        .toUpperCase(); // "TRAINEE", "ADMIN", etc.

    // Decide initial route
    late final String initialRoute;
    if (token == null || token.isEmpty) {
      // No token, show login screen
      initialRoute = AppRoute.getLoginScreen();
    } else {
      switch (role) {
        case 'TRAINEE':
          debugPrint('Role: $role');
          initialRoute = AppRoute.getBottomNavBarScreen();
          break;
        case 'ADMIN':
          initialRoute = AppRoute.getBottomNavbarAdmin();
          break;
        case 'SUPER_ADMIN':
          debugPrint('Role: $role');
          initialRoute =
              AppRoute.getBottomNavbarAdmin(); // <-- create this route
          break;
        default:
          // Unknown role → fallback to login
          debugPrint('Unknown role: $role, redirecting to login');
          initialRoute = AppRoute.getLoginScreen();
      }
    }

    return ScreenUtilInit(
      designSize: const Size(375, 827),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
