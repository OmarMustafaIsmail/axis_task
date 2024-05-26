import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PopularityCard extends StatelessWidget {
  const PopularityCard({super.key, required this.populartiy});
  final double populartiy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Palette.kPrimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 0.5.h,
        ),
        child: Text(
          populartiy.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 8.sp,
            fontWeight: FontWeight.w900,
            color: Palette.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
