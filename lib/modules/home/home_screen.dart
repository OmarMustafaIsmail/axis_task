import 'package:axis_task/modules/home/components/celebrity_card.dart';
import 'package:axis_task/modules/home/cubit/cubit.dart';
import 'package:axis_task/modules/home/cubit/states.dart';
import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/shared/components/infinite_list_view.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onLoadMore() async {
    context.read<HomeScreenCubit>().getCelebrities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenStates>(
        builder: (context, state) {
      List<CelebrityModel> celebrities = [];
      bool canLoadMore = true;

      if (state is HomeScreenLoadingDataState) {
        celebrities = state.oldCelebrities;
      } else if (state is HomeScreenDataState) {
        celebrities = state.celebrities;
        canLoadMore = state.hasMorePages;
      }
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 20.h,
                  ),
                ),
                Text(
                  'Celebrities',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: Palette.kLightRedColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: InfiniteListView(
                    padding: EdgeInsets.zero,
                    itemCount: celebrities.length,
                    itemBuilder: (context, index) {
                      return CelebrityCard(
                        celebrity: celebrities[index],
                      );
                    },
                    onLoadMore: _onLoadMore,
                    canLoadMore: canLoadMore,
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
