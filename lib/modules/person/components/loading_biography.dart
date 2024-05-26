import 'package:axis_task/shared/components/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingBiography extends StatelessWidget {
  const LoadingBiography({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: loadingShimmer(radius: 50, height: 1.h, width: 100.w),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: loadingShimmer(radius: 50, height: 1.h, width: 80.w),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: loadingShimmer(radius: 50, height: 1.h, width: 50.w),
        ),
      ],
    );
  }
}
