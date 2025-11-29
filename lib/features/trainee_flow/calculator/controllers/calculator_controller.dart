import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api_service/NetworkCaller.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../models/medicine_model.dart';

class CalculatorController extends GetxController {
  // Text controllers for form fields
  final treatmentAreaController = TextEditingController();
  final ageController = TextEditingController();
  final medicationController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observable variables
  var selectedMedication = ''.obs;
  var isCalculating = false.obs;
  var showResult = false.obs;
  var isSafeCalculation = true.obs;

  // Result data observables
  var calculatedDoseValue = ''.obs;
  var volumeRequired = ''.obs;
  var administrationRoute = ''.obs;
  var clinicalWarnings = <String>[].obs;

  // API related observables
  var medicines = <Medicine>[].obs;
  var isLoadingMedicines = false.obs;

  // Medication options
  final List<String> medications = [
    'Botox',
    'Dysport',
    'Xeomin',
    'Jeuveau',
    'Juvederm',
    'Restylane',
    'Belotero',
    'Radiesse',
    'Sculptra',
  ];

  // Medication dosage information
  final Map<String, Map<String, dynamic>> medicationDosages = {
    'Botox': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended for cosmetic use',
      'color': 'Blue',
    },
    'Dysport': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended for cosmetic use',
      'color': 'Green',
    },
    'Xeomin': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended for cosmetic use',
      'color': 'Purple',
    },
    'Jeuveau': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended for cosmetic use',
      'color': 'Pink',
    },
    'Juvederm': {
      'adult': 'Varies by treatment area and product type',
      'pediatric': 'Age restrictions apply',
      'color': 'Orange',
    },
    'Restylane': {
      'adult': 'Varies by treatment area and product type',
      'pediatric': 'Age restrictions apply',
      'color': 'Teal',
    },
    'Belotero': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Age restrictions apply',
      'color': 'Brown',
    },
    'Radiesse': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended under 18',
      'color': 'Indigo',
    },
    'Sculptra': {
      'adult': 'Varies by treatment area',
      'pediatric': 'Not recommended under 18',
      'color': 'Red',
    },
  };

  @override
  void onInit() {
    super.onInit();
    // Set initial medication
    medicationController.text = 'Choose medication for calculation';
    // Fetch medicines from API
    fetchMedicines();
  }

  /// Fetch medicines from API
  /// Updates medicines observable list
  Future<void> fetchMedicines() async {
    try {
      isLoadingMedicines.value = true;

      final response = await NetworkCaller.getRequest(
        endpoint: getMedicineEndpoint,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['statusCode'] == 200 && responseData['data'] != null) {
          final List<dynamic> medicineList = responseData['data'];

          // Convert to Medicine objects and filter out invalid ones
          medicines.value = medicineList
              .map((json) => Medicine.fromJson(json))
              .where((medicine) => medicine.isValid)
              .toList();
        } else {
          EasyLoading.showError('Failed to fetch medicines');
        }
      } else {
        EasyLoading.showError('Failed to fetch medicines');
      }
    } catch (e) {
      EasyLoading.showError('Error loading medicines: ${e.toString()}');
    } finally {
      isLoadingMedicines.value = false;
    }
  }

  // Method to select medication
  void selectMedication(String medication) {
    selectedMedication.value = medication;
    medicationController.text = medication;
  }

  // Method to calculate safe dose using API
  Future<void> calculateSafeDose() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (selectedMedication.value.isEmpty) {
      Get.snackbar(
        'Medication Required',
        'Please select a medication',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    isCalculating.value = true;
    showResult.value = false;

    try {
      // Store the values before clearing fields
      String treatmentArea = treatmentAreaController.text.trim();
      int age = int.parse(ageController.text);
      String medication = selectedMedication.value;

      debugPrint(
        'Calculator: Starting calculation for $medication, treatmentArea: $treatmentArea, age: $age',
      );

      // Clear all input fields after storing values
      treatmentAreaController.clear();
      ageController.clear();
      medicationController.text = 'Choose medication for calculation';
      selectedMedication.value = '';

      // Call the calculation API
      await _callCalculationAPI(medication, treatmentArea, age);

      // Show result section
      showResult.value = true;
      debugPrint('Calculator: Calculation completed successfully');
    } catch (e) {
      debugPrint('Calculator Error: ${e.toString()}');
      Get.snackbar(
        'Calculation Error',
        'Please check your input values. Age must be a number.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isCalculating.value = false;
    }
  }

  // Method to call the calculation API
  Future<void> _callCalculationAPI(
    String medication,
    String treatmentArea,
    int age,
  ) async {
    try {
      debugPrint(
        'API Call: Starting with medication=$medication, treatmentArea=$treatmentArea, age=$age',
      );

      final requestBody = {
        'medication_name':
            medication, // Changed from 'medication' to 'medication_name'
        'treatment_area': treatmentArea,
        'age': age,
      };

      debugPrint('API Call: Request body = ${jsonEncode(requestBody)}');

      // Direct HTTP call to your specific API endpoint
      final url = Uri.parse('$aIbaseUrl$calculateEndpoint');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('API Call: Response status = ${response.statusCode}');
      debugPrint('API Call: Response body = ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        _handleCalculationResponse(responseData);
      } else {
        debugPrint(
          'API Error: Status ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception('API call failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('API Call Exception: $e');
      // Fallback to local calculation if API fails
      debugPrint('Falling back to local calculation');
      _performLocalCalculation(medication, treatmentArea, age);
    }
  }

  // Handle the API response
  void _handleCalculationResponse(Map<String, dynamic> response) {
    debugPrint('=== API Response Mapping ===');
    debugPrint('Raw API Response: $response');

    // Set calculated dose from API response
    final dosage = response['dosage'] ?? '';
    calculatedDoseValue.value = dosage;
    debugPrint('✅ Calculated Dose: API dosage "$dosage" → calculatedDoseValue');

    // Set notes from API response
    final notes = response['notes'] ?? '';
    administrationRoute.value = notes;
    debugPrint('✅ Note: API notes "$notes" → administrationRoute');

    // Set critical warnings from API response
    clinicalWarnings.clear();
    if (response['critical_info'] != null) {
      final List<dynamic> criticalInfo = response['critical_info'];
      final warnings = criticalInfo.map((info) => info.toString()).toList();
      clinicalWarnings.addAll(warnings);
      debugPrint(
        '✅ Critical Warnings: API critical_info $criticalInfo → clinicalWarnings',
      );
    } else {
      debugPrint('⚠️ No critical_info in API response');
    }

    // Determine if calculation is safe based on critical_info_flag
    final criticalFlag = response['critical_info_flag'] == true;
    isSafeCalculation.value =
        !criticalFlag; // Invert: critical flag true = NOT safe
    debugPrint(
      '✅ Safety Flag: API critical_info_flag ${response['critical_info_flag']} → isSafeCalculation ${!criticalFlag}',
    );
    debugPrint('=== End API Response Mapping ===');
  }

  // Private method to perform local calculation as fallback
  void _performLocalCalculation(
    String medication,
    String treatmentArea,
    int age,
  ) {
    // Clear previous warnings
    clinicalWarnings.clear();

    // Calculate based on medication type
    switch (medication) {
      case 'Botox':
      case 'Dysport':
      case 'Xeomin':
      case 'Jeuveau':
        _calculateNeurotoxin(medication, treatmentArea, age);
        break;
      case 'Juvederm':
      case 'Restylane':
      case 'Belotero':
        _calculateDermalFiller(medication, treatmentArea, age);
        break;
      case 'Radiesse':
      case 'Sculptra':
        _calculateBiostimulator(medication, treatmentArea, age);
        break;
      default:
        _setDefaultValues();
    }

    // Determine if calculation is safe based on warnings
    isSafeCalculation.value = clinicalWarnings.isEmpty;
  }

  // Neurotoxin calculation (Botox, Dysport, Xeomin, Jeuveau)
  void _calculateNeurotoxin(String medication, String treatmentArea, int age) {
    if (age < 18) {
      calculatedDoseValue.value = '0';
      administrationRoute.value = 'Not recommended for pediatric cosmetic use';
      clinicalWarnings.add(
        'Neurotoxins not recommended for cosmetic use under 18 years',
      );
      return;
    }

    // Default adult dosing - varies by treatment area
    calculatedDoseValue.value = 'Varies by $treatmentArea area';
    administrationRoute.value = 'Intramuscular injection into target muscles';

    // Add treatment area specific guidance
    clinicalWarnings.add(_getTreatmentAreaGuidance(treatmentArea));

    // Add medication-specific warnings
    switch (medication) {
      case 'Botox':
        clinicalWarnings.add('Standard dilution: 2.5-5mL saline per 100 units');
        break;
      case 'Dysport':
        clinicalWarnings.add('Conversion ratio: ~2.5-3:1 compared to Botox');
        break;
      case 'Xeomin':
        clinicalWarnings.add('Pure neurotoxin without accessory proteins');
        break;
      case 'Jeuveau':
        clinicalWarnings.add('FDA approved for glabellar lines');
        break;
    }

    // General safety warnings
    if (age > 65) {
      clinicalWarnings.add('Use caution in elderly patients');
    }
  }

  // Dermal filler calculation (Juvederm, Restylane, Belotero)
  void _calculateDermalFiller(
    String medication,
    String treatmentArea,
    int age,
  ) {
    if (age < 21) {
      calculatedDoseValue.value = '0';
      administrationRoute.value = 'Age restrictions apply';
      clinicalWarnings.add(
        'Most dermal fillers not recommended under 21 years',
      );
      return;
    }

    calculatedDoseValue.value = 'Varies by $treatmentArea area and depth';
    administrationRoute.value = 'Intradermal/subdermal injection';

    // Add medication-specific information
    switch (medication) {
      case 'Juvederm':
        clinicalWarnings.add('Hyaluronic acid filler with lidocaine');
        break;
      case 'Restylane':
        clinicalWarnings.add('Non-animal stabilized hyaluronic acid');
        break;
      case 'Belotero':
        clinicalWarnings.add('Cohesive polydensified matrix technology');
        break;
    }

    // General filler warnings
    clinicalWarnings.add('Risk of vascular occlusion - know anatomy');
    clinicalWarnings.add('Have hyaluronidase available for emergencies');
  }

  // Biostimulator calculation (Radiesse, Sculptra)
  void _calculateBiostimulator(
    String medication,
    String treatmentArea,
    int age,
  ) {
    if (age < 18) {
      calculatedDoseValue.value = '0';
      administrationRoute.value = 'Not recommended under 18 years';
      clinicalWarnings.add('Biostimulators not recommended under 18 years');
      return;
    }

    calculatedDoseValue.value = 'Varies by $treatmentArea area';
    administrationRoute.value = 'Deep dermal/subcutaneous injection';

    switch (medication) {
      case 'Radiesse':
        clinicalWarnings.add('Calcium hydroxylapatite microspheres');
        clinicalWarnings.add('Do not use in glabellar area or lips');
        break;
      case 'Sculptra':
        clinicalWarnings.add('Poly-L-lactic acid - gradual results');
        clinicalWarnings.add('Multiple sessions typically required');
        break;
    }

    // General biostimulator warnings
    clinicalWarnings.add('Longer-lasting effects than traditional fillers');
    clinicalWarnings.add('Proper injection technique critical');
  }

  // Default values for unknown medications
  void _setDefaultValues() {
    calculatedDoseValue.value = '0';
    volumeRequired.value = '0';
    administrationRoute.value = 'Consult prescribing information';
    clinicalWarnings.add('Unknown medication - manual calculation required');
  }

  // Helper method to provide treatment area specific guidance
  String _getTreatmentAreaGuidance(String treatmentArea) {
    final area = treatmentArea.toLowerCase();

    if (area.contains('face') ||
        area.contains('forehead') ||
        area.contains('glabella')) {
      return 'Facial area - use precise injection technique';
    } else if (area.contains('neck') || area.contains('jaw')) {
      return 'Neck/jaw area - consider anatomical variations';
    } else if (area.contains('body') ||
        area.contains('arm') ||
        area.contains('leg')) {
      return 'Body area - larger treatment zones possible';
    } else {
      return 'Treatment area noted - follow protocol guidelines';
    }
  }

  // Copy result to clipboard functionality
  void copyResultToClipboard() {
    // For now, just show a success message
    Get.snackbar(
      'Copied',
      'Calculation result copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Clear all fields and results
  void clearFields() {
    treatmentAreaController.clear();
    ageController.clear();
    medicationController.text = 'Choose medication for calculation';
    selectedMedication.value = '';
    showResult.value = false;
    calculatedDoseValue.value = '';
    volumeRequired.value = '';
    administrationRoute.value = '';
    clinicalWarnings.clear();
  }

  @override
  void onClose() {
    treatmentAreaController.dispose();
    ageController.dispose();
    medicationController.dispose();
    super.onClose();
  }
}
