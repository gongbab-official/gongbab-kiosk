import 'package:flutter/material.dart';
import 'package:gongbab/app/ui/phone_number_input/phone_number_input_screen.dart';
import 'package:gongbab/app/router/AppRoutes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.root,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.root,
        builder: (BuildContext context, GoRouterState state) {
          return const PhoneNumberInputScreen();
        },
      ),
    ],
  );
}
