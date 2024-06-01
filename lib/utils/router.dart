import 'package:axis_task/modules/home/presentation/home_screen.dart';
import 'package:axis_task/modules/person/presentation/celebrity_details_screen.dart';
import 'package:axis_task/modules/person/presentation/image_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/celebrity_details',
      pageBuilder: (context, state) =>
          buildPageWithSlideTransition(const CelebrityDetailsScreen(), state),
    ),
    GoRoute(
      path: '/image_screen/:path/:actorName',
      pageBuilder: (context, state) => buildPageWithSlideTransition(
          ImageScreen(
            imagePath: state.pathParameters['path']!,
            actorName: state.pathParameters['actorName']!,
          ),
          state),
    ),
  ],
);
CustomTransitionPage buildPageWithSlideTransition(
    Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: child,
      );
    },
  );
}
