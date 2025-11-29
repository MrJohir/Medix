import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_card.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';

class JurisdictionDropdown extends StatelessWidget {
  final String? selectedCountry;
  final Function(String)? onChanged;
  final bool isExpanded;
  final Function(bool)? onToggle;

  JurisdictionDropdown({
    super.key,
    this.selectedCountry,
    this.onChanged,
    this.isExpanded = false,
    this.onToggle,
  });

  // List of countries with their flags
  final List<Map<String, String>> _countries = [
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'Middle East', 'flag': '🇦🇪'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'New Zealand', 'flag': '🇳🇿'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (onToggle != null) {
              onToggle!(!isExpanded);
            }
          },
          child: AppCard(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.szW12,
              vertical: AppSizes.szH4,
            ),
            child: Row(
              children: [
                // Flag section
                Row(
                  children: [
                    Container(
                      width: AppSizes.szW40,
                      height: AppSizes.szH40,
                      alignment: Alignment.center,
                      child: _buildFlag(selectedCountry),
                    ),

                    // Dropdown arrow
                    Container(
                      padding: EdgeInsets.all(AppSizes.szW8),
                      child: SvgIconHelper.buildIcon(
                        assetPath: IconPath.icDown,
                        height: 12,
                        width: 12,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 50,
                  width: 1,
                  decoration: BoxDecoration(color: const Color(0xFFEDF1F3)),
                ),

                // Dropdown content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedCountry?.isEmpty ?? true
                            ? 'Select Jurisdiction'
                            : selectedCountry!,
                        style: getTsInputPlaceholder(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Dropdown list when expanded
        if (isExpanded)
          Container(
            margin: EdgeInsets.only(top: AppSizes.szH8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.szR8),
              border: Border.all(color: Colors.grey[200]!),
              color: Colors.grey[50],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                final country = _countries[index];
                return ListTile(
                  leading: Text(
                    country['flag']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  title: Text(
                    country['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    if (onChanged != null) {
                      onChanged!(country['name']!);
                    }
                    if (onToggle != null) {
                      onToggle!(false); // Close the dropdown after selection
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildFlag(String? countryName) {
    if (countryName == null || countryName.isEmpty) {
      return const Icon(Icons.flag, color: Colors.grey, size: 24);
    }

    final country = _countries.firstWhere(
      (c) => c['name'] == countryName,
      orElse: () => {'name': '', 'flag': ''},
    );
    return Text(country['flag'] ?? '', style: const TextStyle(fontSize: 24));
  }
}
