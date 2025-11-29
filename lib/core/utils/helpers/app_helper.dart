import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelperFunctions {
  AppHelperFunctions._();
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title, style: const TextStyle(color: Colors.red)),
          content: Text(message, style: const TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  // -------------------------
  // GetX Custom Snackbars
  // -------------------------
  static void showSuccessSnackBar(
    String message, {
    String title = 'Success',
    Duration duration = const Duration(seconds: 3),
  }) {
    _showGetSnackBar(
      title: title,
      message: message,
      bgColor: Colors.green.shade600,
      icon: Icons.check_circle_outline,
      duration: duration,
    );
  }

  static void showErrorSnackBar(
    String message, {
    String title = 'Error',
    Duration duration = const Duration(seconds: 4),
  }) {
    _showGetSnackBar(
      title: title,
      message: message,
      bgColor: Colors.red.shade600,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  static void showInfoSnackBar(
    String message, {
    String title = 'Info',
    Duration duration = const Duration(seconds: 3),
  }) {
    _showGetSnackBar(
      title: title,
      message: message,
      bgColor: Colors.blue.shade600,
      icon: Icons.info_outline,
      duration: duration,
    );
  }

  // Base helper (private)
  static void _showGetSnackBar({
    required String title,
    required String message,
    required Color bgColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(14),
      borderRadius: 12,
      backgroundColor: bgColor,
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white),
      shouldIconPulse: true,
      isDismissible: true,
      duration: duration,
      overlayBlur: 0, // set >0 if you want a blur effect
      overlayColor: Colors.transparent,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
    );
  }
}
