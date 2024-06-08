import 'package:axis_task/modules/person/presentation/cubit/cubit.dart';
import 'package:axis_task/utils/network/remote/end_points.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen(
      {super.key, required this.imagePath, required this.actorName});
  final String imagePath;
  final String actorName;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Future<void> _saveImage() async {
    final result = await context
        .read<CelebrityDetailsCubit>()
        .saveImageToDevice(
            imagePath: widget.imagePath, celebrityName: widget.actorName);

    if (result && mounted) {
        context.pop();
      }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "${ApiConstants.baseImageUrlOriginal}/${widget.imagePath}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 3.h,
              right: 5.w,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Palette.kWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 3.h,
              left: 5.w,
              child: GestureDetector(
                onTap: _saveImage,
                child: Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Palette.kWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.file_download_outlined,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
