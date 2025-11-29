import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/features/common/settings/controllers/settings_controller.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/controllers/triage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmergencyProtocolScreen extends StatelessWidget {
  final TriageController controller = Get.put(TriageController());
  final SettingsController settingsController = Get.find<SettingsController>();

  EmergencyProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, size: 22.sp),
        ),
        title: Text(
          "Emergency Protocol",
          style: getTsAppBarTitle(fontSize: 22),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.emargencyProtocolData.isEmpty) {
          return Center(child: Text("No emergency protocol data available."));
        }

        // ✅ Extract API response - data is already extracted in controller
        final response = controller.emargencyProtocolData;

        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSectionCard(
              title: response['title'] ?? "Emergency Protocol",
              subtitle: "Follow these steps carefully",
            ),

            if (response['red_flags'] != null &&
                response['red_flags'].isNotEmpty)
              _buildListCard("Red Flags :", response['red_flags']),

            if (response['immediate_actions'] != null &&
                response['immediate_actions'].isNotEmpty)
              _buildListCard(
                "Immediate Actions :",
                response['immediate_actions'],
              ),

            if (response['follow_up'] != null &&
                response['follow_up'].isNotEmpty)
              _buildListCard(
                "Follow-up :",
                response['follow_up'],
                color: Colors.black,
              ),

            if (response['escalation'] != null &&
                response['escalation'].toString().isNotEmpty)
              _buildTextCard(
                "Escalation ",
                response['escalation'],
                color: Colors.black,
              ),

            if (response['reporting'] != null &&
                response['reporting'].toString().isNotEmpty)
              _buildTextCard(
                "Reporting ",
                response['reporting'],
                color: Colors.black,
              ),

            if (response['medications'] != null &&
                response['medications'].isNotEmpty)
              _buildListCard("Medications :", response['medications']),
          ],
        );
      }),
    );
  }

  Widget _buildSectionCard({required String title, String? subtitle}) {
    final regex = RegExp(
      r'[\[\(](.*?)[\]\)]',
    ); // Match brackets but capture inside text
    final matches = regex.allMatches(title).toList();

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),

      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            matches.isEmpty
                ? Text(
                    title,
                    style: getTsRegularText(
                      fontSize: 16,
                      color: AppColors.black,
                      lineHeight: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: _buildTitleWithoutBrackets(title, matches),
                  ),
            if (subtitle != null) ...[
              SizedBox(height: 10.w),
              Text(
                subtitle,
                style: getTsRegularText(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  lineHeight: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTitleWithoutBrackets(
    String text,
    List<RegExpMatch> matches,
  ) {
    List<Widget> widgets = [];
    int lastIndex = 0;

    for (final match in matches) {
      // Add normal text before bracket
      if (match.start > lastIndex) {
        widgets.add(
          Text(
            text.substring(lastIndex, match.start),
            style: getTsRegularText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              lineHeight: 1.5,
              color: AppColors.textPrimary,
            ),
          ),
        );
      }

      // Add bracket content without the brackets
      final bracketText = match.group(1) ?? "";
      widgets.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.text),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            bracketText,
            style: getTsRegularText(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ),
      );

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < text.length) {
      widgets.add(
        Text(
          text.substring(lastIndex),
          style: getTsRegularText(
            fontSize: 16,
            color: AppColors.text,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildListCard(String title, List<dynamic> items, {Color? color}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),

      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTsRegularText(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color ?? Colors.black,
              ),
            ),
            SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: getTsRegularText(
                        fontSize: 18,
                        lineHeight: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: _parseTextWithBrackets(item.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextCard(String title, String text, {Color? color}) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title :",
              style: getTsRegularText(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
            SizedBox(height: 12),
            RichText(text: TextSpan(children: _parseTextWithBrackets(text))),
          ],
        ),
      ),
    );
  }

  /// 🔹 Helper: Parse text and make [bracketed] parts bold
  List<TextSpan> _parseTextWithBrackets(String text) {
    final regex = RegExp(r'(\[.*?\]|\(.*?\))'); // matches [ ... ] or ( ... )
    final spans = <TextSpan>[];
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: getTsRegularText(
              fontSize: 16,
              lineHeight: 1.6,
              color: AppColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: getTsRegularText(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            lineHeight: 1.6,
            color: AppColors.text,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: getTsRegularText(
            fontSize: 16,
            lineHeight: 1.6,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
      );
    }

    return spans;
  }
}
