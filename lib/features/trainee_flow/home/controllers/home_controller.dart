import 'dart:convert';
import 'package:dermaininstitute/core/api_service/NetworkCaller.dart';
import 'package:dermaininstitute/core/utils/constants/api_constants.dart';
import 'package:dermaininstitute/features/trainee_flow/home/models/user_recent_activity_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  static final Logger _logger = Logger();

  // Observable lists for recent activity data
  final RxList<UserRecentActivity> _recentActivities =
      <UserRecentActivity>[].obs;
  final RxBool _isLoading = false.obs;

  // Getters
  List<UserRecentActivity> get recentActivities => _recentActivities;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Fetch recent activities when controller initializes
    fetchRecentActivities();
  }

  /// Fetch user recent activities from API
  Future<void> fetchRecentActivities() async {
    try {
      _isLoading.value = true;

      final response = await NetworkCaller.getRequest(
        endpoint: userRecentActivityEndpoint,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final apiResponse = UserRecentActivityResponse.fromJson(responseData);

        if (apiResponse.success) {
          _recentActivities.value = apiResponse.data;
          _logger.i(
            'Recent activities fetched successfully: ${apiResponse.data.length} items',
          );
        } else {
          _logger.e('API returned error: ${apiResponse.message}');
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Failed to fetch recent activities';
        _logger.e('API error: $errorMessage');
      }
    } catch (e) {
      _logger.e('Error fetching recent activities: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Refresh recent activities
  Future<void> refreshRecentActivities() async {
    await fetchRecentActivities();
  }
}
