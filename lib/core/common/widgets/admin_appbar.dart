import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String image;
  const AdminAppBar({super.key, required this.title, required this.image});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff292D32), size: 20),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFF050505),
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 1.50,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(backgroundImage: AssetImage(image)),
              Positioned(
                bottom: 3,
                right: 2,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Color(0xffD4D4D4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
