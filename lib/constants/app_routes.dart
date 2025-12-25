import 'package:flutter/material.dart';
import 'package:mysivi_task/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/home_page';

  static Map<String, Widget Function(BuildContext context)> routes = {
    home: (context) => HomePage(),
  };
}
