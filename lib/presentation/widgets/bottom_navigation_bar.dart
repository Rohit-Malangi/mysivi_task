import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_colors.dart' show AppColors;
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/constants/app_strings.dart';

class CustomAdaptiveBottomNav extends StatefulWidget {
  const CustomAdaptiveBottomNav({
    super.key,
    required this.tabBuilder,
    required this.body,
  });

  final Widget Function(BuildContext, int)? tabBuilder;
  final Widget Function(int)? body;

  @override
  State<CustomAdaptiveBottomNav> createState() =>
      _CustomAdaptiveBottomNavState();
}

class _CustomAdaptiveBottomNavState extends State<CustomAdaptiveBottomNav> {
  int _currentIndex = 0;

  static const cupertinoIconsList = [
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(CupertinoIcons.chat_bubble_2),
      ),
      label: AppStrings.home,
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(CupertinoIcons.tag),
      ),
      label: AppStrings.offers,
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(CupertinoIcons.settings_solid),
      ),
      label: AppStrings.settings,
    ),
  ];

  static const materialIconsList = [
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(Icons.chat_bubble_outline_rounded),
      ),
      label: AppStrings.home,
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(Icons.local_offer_outlined),
      ),
      label: AppStrings.offers,
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.four),
        child: Icon(Icons.settings_outlined),
      ),
      label: AppStrings.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: cupertinoIconsList,
              activeColor: AppColors.primary,
              inactiveColor: CupertinoColors.systemGrey,
              backgroundColor: CupertinoColors.white,
              iconSize: Dimens.twentyFour,
            ),
            tabBuilder: (context, index) {
              return Material(
                // type: MaterialType.transparency,
                color: Colors.white,
                child: widget.tabBuilder!(context, index),
              );
            },
          )
        : Scaffold(
            body: widget.body!(_currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: materialIconsList,
              type: BottomNavigationBarType.fixed,
              elevation: Dimens.zero,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              selectedFontSize: Dimens.twelve,
              unselectedFontSize: Dimens.twelve,
              iconSize: Dimens.twentyFour,
            ),
          );
  }
}
