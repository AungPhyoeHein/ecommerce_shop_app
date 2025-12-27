import 'package:ecommerce_shop_app/src/dashboard/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: DashboardUtils.scaffoldKey, body: child);
  }
}
