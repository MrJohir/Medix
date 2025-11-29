import 'package:dermaininstitute/core/utils/constants/app_texts.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.items = const [],
    this.onChanged,
    this.placeholderText = AppText.selectType,
    this.height,
    this.width,
    this.showArrowIcon = true,
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final List<OptionItems<T>> items;
  final ValueChanged<T?>? onChanged;
  final String placeholderText;
  final double? height;
  final double? width;
  final bool showArrowIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: AppSizes.spaceBtwItemsH),
        SelectDropList<T>(
          itemSelected: items.isNotEmpty
              ? items.firstWhere(
                  (item) => item.model == controller.text,
                  orElse: () => OptionItems<T>(
                    model: null,
                    displayTitle: placeholderText,
                  ),
                )
              : OptionItems<T>(model: null, displayTitle: placeholderText),
          dropListModel: DropdownListModel<T>(items),
          onOptionSelected: (optionItem) {
            controller.text = optionItem.model != null
                ? optionItem.model.toString()
                : '';
            onChanged?.call(optionItem.model);
          },
          borderColor: AppColors.border,
          hintText: hintText ?? placeholderText,
          hintColorTitle: AppColors.placeholder,
          showArrowIcon: showArrowIcon,
          width: width ?? double.infinity,
          arrowColor: AppColors.accent,
          textColorTitle: AppColors.text,
          textColorItem: AppColors.text,
          padding: EdgeInsets.all(200),
          paddingDropItem: EdgeInsets.symmetric(
            vertical: AppSizes.szH10,
            horizontal: AppSizes.szW20,
          ),
          dropboxColor: AppColors.primaryBackground,
          dropBoxBorderColor: AppColors.placeholder,
          scrollThumbColor: AppColors.primary,
        ),
      ],
    );
  }
}
