import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  static BottomNavbarController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void moveToCalculator() {
    selectedIndex.value = 2;
  }

  void moveToHome() {
    selectedIndex.value = 0;
  }
}
