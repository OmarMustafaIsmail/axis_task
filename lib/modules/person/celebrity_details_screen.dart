import 'package:axis_task/modules/person/components/celebrity_details_header.dart';
import 'package:axis_task/modules/person/components/loading_biography.dart';
import 'package:axis_task/modules/person/components/photos_grid_view.dart';
import 'package:axis_task/modules/person/cubit/cubit.dart';
import 'package:axis_task/modules/person/cubit/states.dart';
import 'package:axis_task/shared/components/shimmer_widget.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CelebrityDetailsScreen extends StatelessWidget {
  const CelebrityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CelebrityDetailsCubit, CelebrityDetailsStates>(
        builder: (context, state) {
      state as CelebrityDetailsDataState;
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                state.celebrityDetails!.id == -1
                    ? loadingShimmer(radius: 0, height: 30.h, width: 100.w)
                    : CelebrityDetailsHeader(
                        image: state.celebrityDetails!.mainImage,
                        name: state.celebrityDetails!.name,
                        dateOfBirth: state.celebrityDetails!.birthDate,
                        placeOfBirth: state.celebrityDetails!.placeOfBirth,
                      ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.celebrityDetails!.id == -1
                          ? const LoadingBiography()
                          : Text(
                              state.celebrityDetails!.biography,
                              maxLines: 5,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Photograohy',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Palette.kPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      if (state.celebrityDetails!.id != -1)
                        PhotosGridView(
                          images: state.celebrityDetails!.celebrityImages!,
                          actorName: state.celebrityDetails!.name,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
