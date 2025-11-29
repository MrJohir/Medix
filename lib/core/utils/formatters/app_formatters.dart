import 'package:intl/intl.dart';

class AppForMatters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(\${phoneNumber.substring(0, 3)}) \${phoneNumber.substring(3, 6)}-\${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(\${phoneNumber.substring(0, 4)}) \${phoneNumber.substring(4, 7)}-\${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  static String getMaskedPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // If number is between 10-14 digits, mask it
    if (cleanNumber.length >= 10 && cleanNumber.length <= 14) {
      String visiblePart = cleanNumber.substring(0, 4);
      String maskedPart = '*' * (cleanNumber.length - 4);
      return '$visiblePart$maskedPart';
    }

    // If not in range, return as is
    return phoneNumber;
  }


  static getMaskedEmail(String email) {
    // Split username and domain
    final parts = email.split('@');
    if (parts.length != 2) return email; // invalid email fallback

    final username = parts[0];
    final domain = parts[1];

    // If username length > 4, show last 4 chars
    if (username.length > 4) {
      final visiblePart = username.substring(username.length - 4);
      return '***$visiblePart@$domain';
    } else {
      // If username is short (≤4), just show last char
      final visiblePart = username.substring(username.length - 1);
      return '***$visiblePart@$domain';
    }
  }

}
