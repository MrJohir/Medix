import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/features/common/settings/views/widgets/figma_style_switch.dart';
import 'package:flutter/material.dart';

/// Settings Toggle Row Widget
/// Displays a setting with title, subtitle and toggle switch
class SettingsToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(
                title,
                style: getTsSubTitle(
                  color: Color(0xFF141617),
                  lineHeight: 1.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(subtitle, style: getTsRegularText(color: Color(0xFF8993A4))),
            ],
          ),
        ),
        FigmaStyleSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
