import 'package:dermaininstitute/core/utils/constants/colors.dart';
import 'package:dermaininstitute/core/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicTextFieldSection extends StatelessWidget {
  const DynamicTextFieldSection({
    super.key,
    required this.title,
    required this.controllers,
    required this.hintText,
    required this.onAdd,
    required this.onRemove,
  });

  final String title;
  final List<TextEditingController> controllers;
  final String hintText;
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
            children: List.generate(controllers.length, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == controllers.length - 1 ? 0 : 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controllers[index],
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            color: const Color(0xFF1A1C1E),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffEDF1F3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffEDF1F3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffEDF1F3),
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        if (index == 0) {
                          // First item - show add icon
                          onAdd();
                        } else {
                          // Other items - show remove icon
                          onRemove(index);
                        }
                      },
                      icon: Icon(
                        index == 0 ? Icons.add : Icons.remove,
                        color: const Color(0xff12295E),
                      ),
                      splashRadius: AppSizes.szW24,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                          side: const BorderSide(color: Color(0xff12295E)),
                        ),
                        fixedSize: Size(AppSizes.szW38, AppSizes.szH38),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
