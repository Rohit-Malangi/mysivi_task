import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/constants/app_text_styles.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';
import 'package:mysivi_task/constants/app_colors.dart';
import 'package:mysivi_task/utils/gen_random.dart'; // Assuming you have this

class ChatHistoryList extends StatefulWidget {
  final List<User> users;

  const ChatHistoryList({super.key, required this.users});

  @override
  State<ChatHistoryList> createState() => _ChatHistoryListState();
}

class _ChatHistoryListState extends State<ChatHistoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _formatTime(DateTime? time) {
    if (time == null) return "";
    final diff = DateTime.now().difference(time);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour ago";
    } else if (diff.inDays == 1) {
      return "Yesterday";
    } else {
      return "${diff.inDays} days ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.users.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text("No chat history", style: AppTextStyles.body2),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final user = widget.users[index];
        final int unreadCount = index % 3 == 0
            ? GenerateRandom.randomIntTillTen()
            : 0;
        final bool hasUnread = unreadCount > 0;

        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimens.sixteen,
                vertical: Dimens.four,
              ),
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
              title: Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.sixteen,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  user.lastMsg ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Dimens.fourteen,
                  ),
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(user.onlineTime),
                    style: TextStyle(
                      fontSize: Dimens.twelve,
                      fontWeight: hasUnread
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: hasUnread ? AppColors.primary : Colors.grey,
                    ),
                  ),
                  if (hasUnread) ...[
                    const SizedBox(height: Dimens.six),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimens.ten,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (index != widget.users.length - 1)
              const Divider(
                height: 1,
                indent: 84,
                endIndent: 16,
                color: Color(0xFFEEEEEE),
              ),
          ],
        );
      }, childCount: widget.users.length),
    );
  }
}
