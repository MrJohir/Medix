import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:get/get.dart';

class BottomNavbarControllerAdmin extends GetxController {
  static BottomNavbarControllerAdmin get instance => Get.find();
  
  RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<String> activeIcons = [
    IconPath.dashboard1,
    IconPath.sop1,
    IconPath.user1,
    IconPath.settings2,
  ];

  final List<String> inactiveIcons = [
    IconPath.dashboard2,
    IconPath.sop2,
    IconPath.user2,
    IconPath.settings1,
  ];
}
