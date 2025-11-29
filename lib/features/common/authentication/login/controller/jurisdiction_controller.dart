import 'package:get/get.dart';

class JurisdictionController extends GetxController {
  var selectedCountry = ''.obs;
  var isExpanded = false.obs;

  // Countries data
  final List<Map<String, String>> countries = [
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'Middle East', 'flag': '🇦🇪'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'New Zealand', 'flag': '🇳🇿'},
  ];

  void setSelectedCountry(String country) {
    selectedCountry.value = country;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void setExpanded(bool expanded) {
    isExpanded.value = expanded;
  }

  void clearSelection() {
    selectedCountry.value = '';
    isExpanded.value = false;
  }

  // Method to get selected country info
  Map<String, String>? getSelectedCountryInfo() {
    if (selectedCountry.value.isEmpty) return null;
    return countries.firstWhere(
      (country) => country['name'] == selectedCountry.value,
      orElse: () => {'name': '', 'flag': ''},
    );
  }

  // Method to check if country is selected
  bool get isCountrySelected => selectedCountry.value.isNotEmpty;

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
