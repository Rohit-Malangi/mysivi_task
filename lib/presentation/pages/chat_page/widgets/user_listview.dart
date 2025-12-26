import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/constants/app_strings.dart';
import 'package:mysivi_task/constants/app_text_styles.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';
import 'package:mysivi_task/presentation/pages/message_page/message_page.dart';
import 'package:mysivi_task/utils/string_helper.dart';

class UsersListView extends StatefulWidget {
  final List<User> users;

  const UsersListView({super.key, required this.users});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.users.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(AppMessages.emptyListMsg, style: AppTextStyles.body2),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final user = widget.users[index];

        return Column(
          children: [
            ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: user.color.withValues(alpha: 0.2),
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: TextStyle(
                        color: user.color,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.eighteen,
                      ),
                    ),
                  ),
                  if (user.isOnline)
                    Positioned(
                      right: Dimens.zero,
                      bottom: Dimens.zero,
                      child: Container(
                        width: Dimens.twelve,
                        height: Dimens.twelve,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: Dimens.two,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(user.name),
              subtitle: Text(
                user.isOnline
                    ? "Online"
                    : StringHelper.formatLastOnline(user.onlineTime),
                style: TextStyle(
                  color: user.isOnline ? Colors.green : Colors.grey,
                  fontSize: Dimens.twelve,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MessagePage(user: user)),
              ),
            ),
            if (index != widget.users.length - 1)
              const Divider(
                height: 1,
                indent: 75,
                endIndent: 16,
                color: Color(0xFFEEEEEE),
              ),
          ],
        );
      }, childCount: widget.users.length),
    );
  }
}
