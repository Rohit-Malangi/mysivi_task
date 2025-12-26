import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_strings.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppStrings.settings));
  }
}
