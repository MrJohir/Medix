import 'package:get/get.dart';
import 'package:dermaininstitute/core/utils/logging/logger.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/all_sop_model.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/models/protocol_enums.dart';
import 'package:dermaininstitute/features/trainee_flow/protocols/protocal_services/all_protocal_services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProtocolsController extends GetxController {
  final SopService _sopService = SopService();

  // observable variables using Sop model
  final RxList<Sop> _allProtocols = <Sop>[].obs;
  final RxList<Sop> filteredProtocols = <Sop>[].obs;
  final RxString searchQuery = ''.obs;
  final Rx<ProtocolLocation> selectedLocation = ProtocolLocation.all.obs;
  final Rx<ProtocolCategory> selectedCategory =
      ProtocolCategory.allCategories.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // getters
  List<Sop> get allProtocols => _allProtocols;

  @override
  void onInit() {
    super.onInit();
    // load protocols from API
    loadProtocols();

    // listen to search query changes with debounce
    debounce(
      searchQuery,
      _performSearch,
      time: const Duration(milliseconds: 800),
    );

    // listen to filter changes
    ever(selectedLocation, (_) => _applyFilters());
    ever(selectedCategory, (_) => _applyFilters());
  }

  /// load all protocols from API
  Future<void> loadProtocols() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      AppLoggerHelper.info('Loading all protocols...');

      final result = await _sopService.fetchAllSop();
      _allProtocols.assignAll(result);
      _applyFilters();

      AppLoggerHelper.info('Successfully loaded ${result.length} protocols');
    } catch (e) {
      errorMessage.value = 'Failed to load protocols: ${e.toString()}';
      AppLoggerHelper.error('Error loading protocols: $e');
      EasyLoading.showError('Failed to load protocols');
    } finally {
      isLoading.value = false;
    }
  }

  /// search protocols with query
  void _performSearch(String query) {
    AppLoggerHelper.info('Performing search with query: "$query"');
    _applyFilters();
  }

  // search functionality
  void updateSearchQuery(String query) {
    searchQuery.value = query.trim();
  }

  // location filter functionality
  void selectLocation(ProtocolLocation location) {
    AppLoggerHelper.info('Location filter changed to: ${location.value}');
    selectedLocation.value = location;
  }

  // category filter functionality
  void selectCategory(ProtocolCategory category) {
    AppLoggerHelper.info('Category filter changed to: ${category.value}');
    selectedCategory.value = category;
  }

  // apply all filters (location, category, search)
  void _applyFilters() {
    List<Sop> filtered = List.from(_allProtocols);

    // apply search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((protocol) {
        return protocol.title.toLowerCase().contains(query) ||
            protocol.overview.toLowerCase().contains(query) ||
            protocol.tags.any((tag) => tag.toLowerCase().contains(query)) ||
            protocol.indications.any(
              (indication) => indication.toLowerCase().contains(query),
            );
      }).toList();
    }

    // apply location filter
    if (selectedLocation.value != ProtocolLocation.all) {
      filtered = filtered.where((protocol) {
        return protocol.location == selectedLocation.value;
      }).toList();
    }

    // apply category filter
    if (selectedCategory.value != ProtocolCategory.allCategories) {
      filtered = filtered.where((protocol) {
        return protocol.category == selectedCategory.value;
      }).toList();
    }

    // sort by updated date (newest first)
    filtered.sort((a, b) => b.updatedDate.compareTo(a.updatedDate));

    filteredProtocols.assignAll(filtered);

    AppLoggerHelper.info(
      'Applied filters - showing ${filtered.length} of ${_allProtocols.length} protocols',
    );
  }

  // clear all filters
  void clearFilters() {
    AppLoggerHelper.info('Clearing all filters');
    searchQuery.value = '';
    selectedLocation.value = ProtocolLocation.all;
    selectedCategory.value = ProtocolCategory.allCategories;
  }

  // refresh protocols (for pull-to-refresh)
  Future<void> refreshProtocols() async {
    AppLoggerHelper.info('Refreshing protocols...');
    await loadProtocols();
  }

  // get protocol details by ID
  Sop? getProtocolDetails(String protocolId) {
    try {
      return _allProtocols.firstWhereOrNull(
        (protocol) => protocol.id == protocolId,
      );
    } catch (e) {
      AppLoggerHelper.error('Error getting protocol details: $e');
      return null;
    }
  }

  // get protocols count by category (from filtered list)
  int getProtocolsCountByCategory(ProtocolCategory category) {
    if (category == ProtocolCategory.allCategories) {
      return filteredProtocols.length;
    }
    return filteredProtocols
        .where((protocol) => protocol.category == category)
        .length;
  }

  // get protocols count by location (from filtered list)
  int getProtocolsCountByLocation(ProtocolLocation location) {
    if (location == ProtocolLocation.all) {
      return filteredProtocols.length;
    }
    return filteredProtocols
        .where((protocol) => protocol.location == location)
        .length;
  }

  // helper method to format date for display
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference < 365) {
      final months = (difference / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
