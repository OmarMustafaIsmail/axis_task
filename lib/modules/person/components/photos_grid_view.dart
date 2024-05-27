import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView(
      {required this.actorName, required this.images, super.key});
  final List<String> images;
  final String actorName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // maxCrossAxisExtent: 190,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                context.push('/image_screen${images[index]}/$actorName'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${ApiConstants.baseImageUrl}${images[index]}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
