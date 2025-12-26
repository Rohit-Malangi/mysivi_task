part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class UserAddedState extends HomePageState {}

final class GetChatMessagesListLoadingState extends HomePageState {
  final bool isLoading;

  GetChatMessagesListLoadingState({required this.isLoading});
}

final class GetChatMessagesListState extends HomePageState {
  final List<ChatMessage> list;

  GetChatMessagesListState({required this.list});
}

final class HomePageErrorState extends HomePageState {
  final String msg;

  HomePageErrorState({required this.msg});
}
