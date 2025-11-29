import 'package:flutter/material.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:dermaininstitute/features/trainee_flow/emergency_protocols/models/emergency_protocol_model.dart';

class ProtocolItem extends StatelessWidget {
  final EmergencyProtocol protocol;
  final VoidCallback onToggle;

  const ProtocolItem({
    super.key,
    required this.protocol,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.szH16),
      padding: EdgeInsets.all(AppSizes.szW20), // 20px padding
      decoration: BoxDecoration(
        color: protocol.isUrgent
            ? Color(0xFFF8F0F1) // Warning background color (always for urgent items)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.szR12), // 12px border radius
        border: Border.all(
          color: protocol.isUrgent
              ? Color(0xFFFFD7D7) // Warning border color (always for urgent items)
              : Color(0xFFDFE1E6), // Normal border color
          width: 1, // Border width 1
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox and Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              GestureDetector(
                onTap: onToggle,
                child: Container(
                  width: AppSizes.szW24,
                  height: AppSizes.szW24,
                  decoration: BoxDecoration(
                    color: protocol.isCompleted ? Color(0xFF12295E) : Colors.transparent,
                    border: Border.all(
                      color: protocol.isCompleted ? Color(0xFF12295E) : Colors.grey.shade400,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.szR4),
                  ),
                  child: protocol.isCompleted
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: AppSizes.font16,
                        )
                      : null,
                ),
              ),

              SizedBox(width: AppSizes.szW12),

              // Title and urgency indicator
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        protocol.title,
                        style: TextStyle(
                          fontSize: AppSizes.font14, // Title font size 14
                          fontWeight: FontWeight.w500, // Title font weight w500
                          color: Color(0xFF141617),
                        ),
                      ),
                    ),
                    if (protocol.isUrgent) // Show warning icon for all urgent items
                      Icon(
                        Icons.warning_amber_rounded, // Unfilled warning_rounded
                        color: Colors.red,
                        size: AppSizes.font20,
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Time limit after the title
          if (protocol.timeLimit.isNotEmpty) ...[
            SizedBox(height: AppSizes.szH8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: AppSizes.font14,
                  color: Color(0xFF172B4D),
                ),
                SizedBox(width: AppSizes.szW4),
                Text(
                  protocol.timeLimit,
                  style: TextStyle(
                    fontSize: AppSizes.font12, // TimeLimit font size 12
                    fontWeight: FontWeight.w400, // TimeLimit font weight w400
                    color: Color(0xFF172B4D),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: AppSizes.szH8),

          // Description placed vertically
          Text(
            protocol.description,
            style: TextStyle(
              fontSize: AppSizes.font12, // Description font size 12
              fontWeight: FontWeight.w400, // Description font weight w400
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
