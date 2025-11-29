import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/common/widgets/custom_note_card.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/core/utils/helpers/svg_icon_helper.dart';
import 'package:flutter/material.dart';

class CriticalSafetyNotice extends StatelessWidget {
  const CriticalSafetyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNoteCard(
      color: 'Blue',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning icon
          SvgIconHelper.buildIcon(assetPath: IconPath.icWarningError),

          SizedBox(height: AppSizes.szW12),

          // Text content
          Text(
            'Critical Safety Notice: Always double-check calculations and verify against local protocols. This calculator provides guidance only and should not replace clinical judgment.',
            style: getTsNotesText(lineHeight: 1.2),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
