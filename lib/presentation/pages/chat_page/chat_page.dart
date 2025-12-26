import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysivi_task/constants/app_colors.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/constants/app_strings.dart';
import 'package:mysivi_task/presentation/bloc/home_page/home_page_bloc.dart';
import 'package:mysivi_task/presentation/models/user_model.dart' show User;
import 'package:mysivi_task/presentation/pages/chat_page/widgets/chat_history_listview.dart';
import 'package:mysivi_task/presentation/pages/chat_page/widgets/user_listview.dart';
import 'package:mysivi_task/presentation/widgets/tab_app_bar.dart';
import 'package:mysivi_task/utils/gen_random.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late HomePageBloc _homePageBloc;

  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();

  int _index = 0;

  @override
  void initState() {
    _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int i) {
    setState(() => _index = i);
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _addUser() {
    _nameController.clear();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppStrings.addUser),
          content: TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: AppStrings.enterUserName,
            ),
            onSubmitted: (_) => _submitUser(context),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () => _submitUser(context),
              child: const Text(AppStrings.add),
            ),
          ],
        );
      },
    );
  }

  void _submitUser(BuildContext context) {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppMessages.emptyName),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    bool isOnline = GenerateRandom.randomBool();
    DateTime? onlineTime;

    if (!isOnline) {
      onlineTime = GenerateRandom.generateRandomPastTime();
    }

    setState(() {
      _homePageBloc.add(
        AddUserEvent(
          user: User(
            name: name,
            color: GenerateRandom.randomColor(),
            isOnline: isOnline,
            onlineTime: onlineTime,
            lastMsg: "It's the last msg",
          ),
        ),
      );
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      elevation: Dimens.zero,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: AppBarSwitcher(index: _index, onChanged: _onTabChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              onPressed: _addUser,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _index = i),
            children: [
              CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  UsersListView(users: _homePageBloc.getUsersList),
                ],
              ),
              CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  ChatHistoryList(users: _homePageBloc.getChatUserList),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
