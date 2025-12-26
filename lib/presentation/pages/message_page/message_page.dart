import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';
import 'package:mysivi_task/presentation/bloc/home_page/home_page_bloc.dart';
import 'package:mysivi_task/presentation/models/chat_message_model.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';
import 'package:mysivi_task/presentation/pages/message_page/widgets/chat_bubble.dart';
import 'package:mysivi_task/utils/string_helper.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.user});

  final User user;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late HomePageBloc _homePageBloc;

  bool isLoading = false;

  @override
  void initState() {
    _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    _homePageBloc.add(GetChatMessagesListEvent(userID: widget.user.userID));
    super.initState();
  }

  List<ChatMessage> messages = [];

  void _listner(BuildContext context, HomePageState state) {
    if (state is GetChatMessagesListLoadingState) {
      isLoading = state.isLoading;
    }

    if (state is GetChatMessagesListState) {
      messages = state.list;
    }

    if (state is HomePageErrorState) {
      Fluttertoast.showToast(
        msg: state.msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        titleSpacing: Dimens.zero,
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        title: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: widget.user.color.withValues(alpha: 0.2),
                child: Text(
                  widget.user.name[0].toUpperCase(),
                  style: TextStyle(
                    color: widget.user.color,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimens.eighteen,
                  ),
                ),
              ),
              if (widget.user.isOnline)
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
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.isOnline
                ? "Online"
                : StringHelper.formatLastOnline(widget.user.onlineTime),
            style: TextStyle(
              color: widget.user.isOnline ? Colors.green : Colors.grey,
              fontSize: Dimens.twelve,
            ),
          ),
        ),
      ),
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: _listner,
        builder: (context, state) {
          return Visibility(
            visible: !isLoading,
            replacement: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: Dimens.sixteen),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index], user: widget.user);
              },
            ),
          );
        },
      ),
    );
  }
}
