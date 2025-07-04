import 'package:demo_first/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:demo_first/features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/checkout/presentation/pages/checkout_page.dart';
import '../../features/home/data/models/product_res_model.dart';
import 'route_paths.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePaths.dashboard,
    routes: [
      GoRoute(
        path: RoutePaths.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RoutePaths.checkout,
        name: RoutePaths.checkout,
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: RoutePaths.productDetail,
        name: RoutePaths.productDetail,
        builder: (context, state) {
          final product = state.extra as ProductResModel;
          return ProductDetailPage(product: product);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error.toString())),
    ),
  );
}
