import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_colors.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/constants/app_strings.dart';

class AppBarSwitcher extends StatelessWidget {
  const AppBarSwitcher({
    super.key,
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.fourty,
      padding: const EdgeInsets.all(Dimens.four),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(Dimens.twenty),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: index == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.sixteen),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: Dimens.four,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              _item(AppStrings.users, 0),
              _item(AppStrings.chatHistory, 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(String label, int i) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(i),
        child: Container(
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: Dimens.sixteen,
              fontWeight: FontWeight.w500,
              color: index == i ? Colors.black : Colors.grey.shade600,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
