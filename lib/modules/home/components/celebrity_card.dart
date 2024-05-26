import 'package:axis_task/modules/home/components/popularity_card.dart';
import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CelebrityCard extends StatelessWidget {
  const CelebrityCard({required this.celebrity, super.key});

  final CelebrityModel celebrity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: ()=>context.read<CelebrityDetailsCubit>().getCelebrityDetails(),
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Palette.kWhiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      '${ApiConstants.baseImageUrl}${celebrity.mainImage}',
                      height: 15.h,
                      width: 30.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        celebrity.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          color: Palette.kPrimaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '(${celebrity.department})',
                            style: TextStyle(
                              color: Palette.kDarkGreyColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 8.sp,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          PopularityCard(populartiy: celebrity.popularity),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Palette.kLightRedColor,
                    ),
                  ],
                )
                // const Align(
                //     alignment: Alignment.bottomRight,
                //     child: Icon(Icons.keyboard_arrow_right))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
