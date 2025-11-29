import 'dart:io';

import 'package:dermaininstitute/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/triage/models/triage_message_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MessageBubble extends StatelessWidget {
  final TriageMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.szH12),
      child: Column(
        crossAxisAlignment: message.isFromUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (message.messageType == 'alert')
            _buildAlertMessage()
          else if (message.isFromUser)
            _buildUserMessage()
          else
            _buildAssistantMessage(),
        ],
      ),
    );
  }

  Widget _buildAlertMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.szR14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(AppSizes.szR12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.red.shade600,
            size: AppSizes.font20,
          ),
          SizedBox(width: AppSizes.szW12),
          Expanded(
            child: Text(
              message.message,
              style: TextStyle(
                fontSize: AppSizes.font12,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage() {
    if (message.imagePath != null && message.imagePath!.isNotEmpty) {
      return Container(
        constraints: BoxConstraints(maxWidth: 200.w, maxHeight: 200.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.szR6),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.szR6),
          child: Image.file(File(message.imagePath!), fit: BoxFit.cover),
        ),
      );
    }

    // fallback to text message
    return Container(
      constraints: BoxConstraints(maxWidth: 250.w),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW14,
        vertical: AppSizes.szH12,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(AppSizes.szR6),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Text(
        message.message,
        style: getTsRegularText(
          fontSize: AppSizes.font14,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          lineHeight: 1.5,
        ),
      ),
    );
  }

  Widget _buildAssistantMessage() {
    // 🔹 Loading AI message
    if (message.id == "loading_ai") {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          constraints: BoxConstraints(maxWidth: 120.w, minHeight: 20.h),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.szW14,
            vertical: AppSizes.szH12,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(AppSizes.szR6),
          ),
        ),
      );
    }

    // Replace '*' with bullet '•' for better formatting

    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.szW14,
        vertical: AppSizes.szH12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(AppSizes.szR6),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message text with line breaks and bullet points
          _buildFormattedMessage(message.message),

          // SizedBox(height: 4.h),

          // // Timestamp
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                fontSize: AppSizes.font10,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Parse message text for bullets (\n*) and bold (**text**) and return RichText
  /// Build a formatted message widget with support for:
  /// - Bullet points (lines starting with `*`)
  /// - Bold text (wrapped in `**bold**`)
  Widget _buildFormattedMessage(String text) {
    final List<TextSpan> spans = [];

    final lines = text.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue; // skip empty lines

      if (line.startsWith('*')) {
        // Handle bullet points
        final content = line.replaceFirst('*', '').trim();
        spans.add(
          TextSpan(
            text: "• ",
            style: getTsRegularText(
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.font14,
              color: Colors.black87,
              lineHeight: 1.5,
            ),
            children: [
              _parseBoldText(content),
              const TextSpan(text: "\n\n"),
            ],
          ),
        );
      } else {
        // Normal line
        spans.add(
          TextSpan(
            children: [
              _parseBoldText(line),
              const TextSpan(text: "\n"),
            ],
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        style: getTsRegularText(
          fontSize: AppSizes.font14,
          color: Colors.black87,
          lineHeight: 1.5,
        ),
        children: spans,
      ),
    );
  }

  /// Detects `**bold**` text and returns styled TextSpans
  TextSpan _parseBoldText(String text) {
    final List<TextSpan> children = [];
    final regex = RegExp(r"\*\*(.*?)\*\*");
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        children.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      children.add(
        TextSpan(
          text: match.group(1),
          style: getTsRegularText(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font14,
            lineHeight: 1.5,
            color: Colors.black87,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      children.add(TextSpan(text: text.substring(lastIndex)));
    }

    return TextSpan(
      children: children,
      style: getTsRegularText(
        fontSize: AppSizes.font14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        lineHeight: 1.5,
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
