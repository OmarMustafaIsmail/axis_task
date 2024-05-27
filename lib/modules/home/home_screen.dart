import 'dart:async';

import 'package:axis_task/modules/home/components/celebrity_card.dart';
import 'package:axis_task/modules/home/cubit/cubit.dart';
import 'package:axis_task/modules/home/cubit/states.dart';
import 'package:axis_task/modules/home/models/celebrity_model.dart';
import 'package:axis_task/shared/components/infinite_list_view.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
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

  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool connectionState = true;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        setState(() {
          connectionState = true;
        });
      } else {
        setState(() {
          connectionState = false;
        });
      }
    });
    super.initState();
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Celebrities',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: Palette.kLightRedColor,
                      ),
                    ),
                    if (!connectionState)
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.info,
                            color: Palette.kDangerRedColor,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Check your intenet connection',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900,
                              color: Palette.kDangerRedColor,
                            ),
                          )
                        ],
                      )
                  ],
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
                        isConnected: connectionState,
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
