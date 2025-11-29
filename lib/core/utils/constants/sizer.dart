import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static const double sz0 = 0;

  /// -- Width Sizes
  static double szW0 = 0.w;
  static double szW1 = 1.w;
  static double szW2 = 2.w;
  static double szW4 = 4.w;
  static double szW5 = 5.w;
  static double szW6 = 6.w;
  static double szW8 = 8.w;
  static double szW10 = 10.w;
  static double szW12 = 12.w;
  static double szW14 = 14.w;
  static double szW16 = 16.w;
  static double szW18 = 18.w;
  static double szW20 = 20.w;
  static double szW22 = 22.w;
  static double szW24 = 24.w;
  static double szW28 = 28.w;
  static double szW30 = 30.w;
  static double szW32 = 32.w;
  static double szW38 = 38.w;
  static double szW40 = 40.w;
  static double szW48 = 48.w;

  static double szW80 = 80.w;

  static double szW52 = 52.w;
  static double szW58 = 58.w;

  static double szW100 = 100.w;
  static double szW120 = 120.w;
  static double szW140 = 140.w;
  static double szW148 = 148.w;

  /// -- Height Sizes
  static double szH2 = 2.h;
  static double szH4 = 4.h;
  static double szH6 = 6.h;
  static double szH8 = 8.h;
  static double szH10 = 10.h;
  static double szH12 = 12.h;
  static double szH13 = 13.h;
  static double szH14 = 14.h;
  static double szH15 = 15.h;
  static double szH16 = 16.h;
  static double szH18 = 18.h;
  static double szH20 = 20.h;
  static double szH24 = 24.h;
  static double szH25 = 25.h;
  static double szH26 = 26.h;
  static double szH28 = 28.h;
  static double szH30 = 30.h;
  static double szH32 = 32.h;
  static double szH38 = 38.h;
  static double szH40 = 40.h;
  static double szH44 = 44.h;
  static double szH48 = 48.h;
  static double szH50 = 50.h;
  static double szH55 = 55.h;
  static double szH52 = 52.h; // -- Used for the button height
  static double szH80 = 80.h; // -- Used for the button height
  static double szH133 = 133.h; // -- Used for the button height
  static double szH140 = 140.h;
  static double szH148 = 148.h;

  /// -- Font Sizes
  static double font10 = 10.sp;
  static double font12 = 12.sp;
  static double font14 = 14.sp;
  static double font16 = 16.sp;
  static double font15 = 15.sp;
  static double font18 = 18.sp;
  static double font20 = 20.sp;
  static double font24 = 24.sp;
  static double font28 = 28.sp;
  static double font32 = 32.sp;
  static double font34 = 34.sp;
  static double font38 = 38.sp;
  static double font40 = 40.sp;
  static double font42 = 42.sp;

  /// -- Margin, Padding and Border Radius
  static double szR2 = 2.r;
  static double szR4 = 4.r;
  static double szR6 = 6.r;
  static double szR7= 7.r;
  static double szR8 = 8.r;
  static double szR10 = 10.r;
  static double szR11 = 11.r;
  static double szR12 = 12.r;
  static double szR14 = 14.r;
  static double szR16 = 16.r;
  static double szR18 = 18.r;
  static double szR20 = 20.r;
  static double szR24 = 24.r;
  static double szR25 = 25.r;
  static double szR32 = 32.r;
  static double szR40 = 40.r;
  static double szR44 = 44.r;
  static double szR50 = 50.r;
  static double szR54 = 54.r;

  /// -- AppBar height
  static double appBarHeight = 56.h;
  static double topHeight = 20.h;
  static double truckHeightFromTop165 = 165.h;

  /// -- Divider height
  static double dividerHeight = 1.h;

  /// -- Line height
  static double lineHeight1_2 = 1.2;
  static double lineHeight1_3 = 1.3;
  static double lineHeight1_4 = 1.4;
  static double lineHeight1_5 = 1.5;
  static double lineHeight1_6 = 1.6;
  static double lineHeight2_0 = 2.0;

  /// -- Default spacing between sections
  static double defaultSpaceH = 16.h;
  static double defaultSpaceW = 16.w;
  static double spaceBtwItemsH = 8.h;
  static double spaceBtwItemsW = 8.w;
  static double spaceBtwSectionsH = 20.h;
  static double spaceBtwSectionsW = 20.w;
  static double spaceMaxBelow = 37.h;

  /// -- Input field
  static double inputFieldRadius = 12.r;
  static double spaceBtwInputFieldsH = 16.h;
  static double spaceBtwInputFieldsW = 16.w;

  /// -- Card sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  /// -- Image carousel height
  static double imageCarouselHeight = 200.h;

  /// -- Loading indicator size
  static const double loadingIndicatorSize = 36.0;

  /// -- Grid view spacing
  static const double gridViewSpacing = 16.0;

  static bool get isLargeDevice {
    // You can adjust the threshold (e.g. 600 = tablet-width in dp)
    return ScreenUtil().screenWidth >= 576;
  }
}
