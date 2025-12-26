import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:mysivi_task/presentation/pages/chat_page.dart';
import 'package:mysivi_task/presentation/pages/offers_page.dart';
import 'package:mysivi_task/presentation/pages/settings_page.dart';
import 'package:mysivi_task/presentation/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomAdaptiveBottomNav(
      tabBuilder: Platform.isIOS
          ? (BuildContext context, int index) {
              switch (index) {
                case 0:
                  return ChatPage();
                case 1:
                  return OffersPage();
                case 2:
                  return SettingsPage();
                default:
                  return SizedBox();
              }
            }
          : null,
      body: Platform.isAndroid
          ? (int index) {
              switch (index) {
                case 0:
                  return ChatPage();
                case 1:
                  return OffersPage();
                case 2:
                  return SettingsPage();
                default:
                  return SizedBox();
              }
            }
          : null,
    );
  }
}
