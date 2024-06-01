import 'dart:io';
import 'package:axis_task/modules/home/presentation/cubit/cubit.dart';
import 'package:axis_task/modules/person/presentation/cubit/cubit.dart';
import 'package:axis_task/shared/globs.dart';
import 'package:axis_task/utils/network/local/cache_manager.dart';
import 'package:axis_task/utils/network/remote/dio_manager.dart';
import 'package:axis_task/utils/palette.dart';
import 'package:axis_task/utils/responsive.dart';
import 'package:axis_task/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.init();
  await DioHelper.init();
  CacheManager.removeData(key: 'celebrities_page_1');
  runApp(const AxisTask());
}

class AxisTask extends StatelessWidget {
  const AxisTask({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final textScaleFactor =
        media.textScaler.scale(Platform.isAndroid ? 0.85 : 0.8);
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                HomeScreenCubit()..getCelebrities(),
          ),
          BlocProvider(
            create: (BuildContext context) => CelebrityDetailsCubit(),
          )
        ],
        child: MediaQuery(
          data: media.copyWith(
              textScaler: !isMobile(context)
                  ? const TextScaler.linear(0.75)
                  : TextScaler.linear(textScaleFactor)),
          child: MaterialApp.router(
            scaffoldMessengerKey: Globals.snackBarKey,
            debugShowCheckedModeBanner: false,
            title: 'Axis',
            theme: ThemeData(
              scaffoldBackgroundColor: Palette.kScaffoldColor,
              fontFamily: 'Montserrat',
              useMaterial3: false,
            ),
            routerConfig: router,
          ),
        ),
      );
    });
  }
}
