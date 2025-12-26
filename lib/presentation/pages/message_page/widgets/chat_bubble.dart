import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_colors.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/presentation/models/chat_message_model.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final User user;

  const ChatBubble({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.twelve,
        vertical: Dimens.six,
      ),
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isSender)
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.eighteen,
                right: Dimens.eight,
              ),
              child: _avatar(user.name, user.color),
            ),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Dimens.twoHundredSixty),
            child: Column(
              crossAxisAlignment: isSender
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.fourteen,
                    vertical: Dimens.ten,
                  ),
                  decoration: BoxDecoration(
                    color: isSender
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.sixteen),
                      topRight: Radius.circular(Dimens.sixteen),
                      bottomLeft: isSender
                          ? Radius.circular(Dimens.sixteen)
                          : Radius.zero,
                      bottomRight: isSender
                          ? Radius.zero
                          : Radius.circular(Dimens.sixteen),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isSender ? Colors.white : Colors.black87,
                      fontSize: Dimens.fourteen,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.four),
                Text(
                  _formatTime(message.time),
                  style: const TextStyle(
                    fontSize: Dimens.ten,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          if (isSender)
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.eighteen,
                left: Dimens.eight,
              ),
              child: _avatar('Rohit', AppColors.primary),
            ),
        ],
      ),
    );
  }

  Widget _avatar(String name, Color color) {
    return CircleAvatar(
      radius: Dimens.fourteen,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        name[0].toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: Dimens.twelve,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
