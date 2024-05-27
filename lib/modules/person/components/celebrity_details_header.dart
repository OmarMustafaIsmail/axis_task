import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CelebrityDetailsHeader extends StatelessWidget {
  const CelebrityDetailsHeader(
      {super.key,
      required this.image,
      required this.name,
      required this.dateOfBirth,
      required this.placeOfBirth});
  final String image;
  final String name;
  final String dateOfBirth;
  final String placeOfBirth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${ApiConstants.baseImageUrl}$image'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 40.h,
          decoration: BoxDecoration(gradient: Palette.opacityGradient),
        ),
        Positioned(
          top: 3.h,
          right: 5.w,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_forward,
              color: Palette.kWhiteColor,
            ),
          ),
        ),
        Positioned(
          bottom: 4.h,
          left: 5.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  color: Palette.kWhiteColor,
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Text(
                  "$placeOfBirth - $dateOfBirth",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Palette.kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
