import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/presentation/widgets/tab_app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final PageController _pageController = PageController();
  int _index = 0;

  void _onTabChanged(int i) {
    setState(() => _index = i);
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: false,
            pinned: false,
            elevation: Dimens.zero,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: LayoutBuilder(
              builder: (context, constraints) {
                final opacity =
                    (constraints.maxHeight - kToolbarHeight).clamp(0, 20) / 20;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: opacity,
                  child: AppBarSwitcher(
                    index: _index,
                    onChanged: _onTabChanged,
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                setState(() => _index = i);
              },
              children: [
                SizedBox(child: Text('Hello')),
                SizedBox(child: Text('Hello 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
