import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:dermaininstitute/features/trainee_flow/reports/controllers/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsSearchBar extends StatelessWidget {
  const ReportsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Obx(() {
      final controller = Get.find<ReportsController>();

      // Update search controller text when search query changes externally
      if (searchController.text != controller.searchQuery) {
        searchController.text = controller.searchQuery;
      }

      return SizedBox(
        height: AppSizes.szH40,
        child: TextField(
          style: TextStyle(fontSize: AppSizes.font12),
          textInputAction: TextInputAction.search,
          controller: searchController,
          onChanged: (value) {
            // Todo: API Integration - This will trigger server-side search
            controller.updateSearchQuery(value);
          },
          onSubmitted: (value) {
            // Todo: API Integration - Trigger focused search on submit
            controller.updateSearchQuery(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR6),
              borderSide: const BorderSide(
                color: Color(0xFFDFE1E6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR6),
              borderSide: const BorderSide(
                color: Color(0xFFDFE1E6),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.szR6),
              borderSide: const BorderSide(
                color: Color(0xFFDFE1E6),
                width: 1,
              ),
            ),
            hintText: 'Search incident logs...',
            suffixIcon: Padding(
              padding: EdgeInsets.all(AppSizes.szR8),
              child: GestureDetector(
                onTap: () {
                  // Todo: API Integration - Trigger search
                  controller.updateSearchQuery(searchController.text);
                },
                child: SvgIconHelper.searchIcon(),
              ),
            ),
            hintStyle: getTsInputPlaceholder(
              lineHeight: 1.4,
              fontSize: AppSizes.font12,
            ),
          ),
        ),
      );
    });
  }
}
