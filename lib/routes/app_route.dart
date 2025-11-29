import 'package:dermaininstitute/features/admin_flow/bottom_nav_bar/views/bottom_navbar_screen.dart';
import 'package:dermaininstitute/features/admin_flow/sops_section/sop_view/views/screens/details_view_screen.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/screens/jurisdiction_screen.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/screens/login_screen.dart';
import 'package:dermaininstitute/features/common/authentication/login/views/screens/signup_screen.dart';
import 'package:dermaininstitute/features/common/settings/views/screens/privacy_policy.dart';
import 'package:dermaininstitute/features/trainee_flow/bottom_nav_bar/ui/screens/bottom_nav_bar.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/ui/screens/protocols_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/screens/create_report_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/create_report/views/screens/draft_reports_screen.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/views/screens/emergency_protocols_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String jurisdictionScreen = "/jurisdictionScreen";
  static String bottomNavBarScreen = "/bottomNavBarScreen";
  static String bottomNavbarAdmin = "/bottomNavbarAdmin";
  static String protocolsScreen = "/protocolsScreen";
  static String createReportScreen = "/createReportScreen";
  static String draftReportsScreen = "/draft-reports";
  static String emergencyProtocolsScreen = "/emergencyProtocolsScreen";
  static String detailsViewScreen = "/detailsViewScreen";
  static String privacyPolicyScreen = "/privacyPolicy";

  // -- GetX Routes ------------------------------------------------------------
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getJurisdictionScreen() => jurisdictionScreen;
  static String getBottomNavBarScreen() => bottomNavBarScreen;
  static String getBottomNavbarAdmin() => bottomNavbarAdmin;
  static String getProtocolsScreen() => protocolsScreen;
  static String getCreateReportScreen() => createReportScreen;
  static String getDraftReportsScreen() => draftReportsScreen;
  static String getEmergencyProtocolsScreen() => emergencyProtocolsScreen;
  static String getDetailsViewScreen() => detailsViewScreen;
  static String getPrivacyPolicyScreen() => privacyPolicyScreen;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: jurisdictionScreen, page: () => JurisdictionScreen()),
    GetPage(name: bottomNavBarScreen, page: () => BottomNavbarScreen()),
    GetPage(name: bottomNavbarAdmin, page: () => BottomNavbarAdmin()),
    GetPage(name: protocolsScreen, page: () => ProtocolsScreen()),
    GetPage(name: createReportScreen, page: () => CreateReportScreen()),
    GetPage(name: draftReportsScreen, page: () => const DraftReportsScreen()),
    GetPage(
      name: emergencyProtocolsScreen,
      page: () => EmergencyProtocolsScreen(),
    ),
    GetPage(
      name: detailsViewScreen,
      page: () => DetailsViewScreen(sopId: Get.parameters['sopId'] ?? ''),
    ),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
  ];
}
