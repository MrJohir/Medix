import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/common/widgets/custom_admin_textfied.dart';

class DynamicComplexSection extends StatelessWidget {
  const DynamicComplexSection({
    super.key,
    required this.title,
    required this.items,
    required this.fieldLabels,
    required this.fieldHints,
    required this.onAdd,
    required this.onRemove,
  });

  final String title;
  final List<Map<String, TextEditingController>> items;
  final List<String> fieldLabels;
  final List<String> fieldHints;
  final VoidCallback onAdd;
  final Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color: Color(0xff333333),
            ),
          ),
        ),
        Obx(
          () => Column(
            children: List.generate(items.length, (index) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 16,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffEDF1F3)),
                ),
                child: Column(
                  children: [
                    // Header with remove button (only for items after first)
                    if (index >
                        0) // Only show remove button for items after first
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => onRemove(index),
                            icon: Icon(
                              Icons.remove,
                              color: const Color(0xff12295E),
                              size: 16,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                                side: const BorderSide(
                                  color: Color(0xff12295E),
                                ),
                              ),
                              fixedSize: Size(10, 10),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    // Dynamic fields based on fieldLabels
                    ...List.generate(fieldLabels.length, (fieldIndex) {
                      final fieldKey = fieldLabels[fieldIndex]
                          .toLowerCase()
                          .replaceAll(' ', '');
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: fieldIndex == fieldLabels.length - 1 ? 0 : 15,
                        ),
                        child: CustomAdminTextField(
                          controller: items[index][fieldKey]!,
                          hintText: fieldHints[fieldIndex],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ),
        ),
        if (items.isNotEmpty) const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            onPressed: onAdd,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff12295E),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            child: Text(
              'Add More',
              style: TextStyle(
                color: const Color(0xffffffff),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
