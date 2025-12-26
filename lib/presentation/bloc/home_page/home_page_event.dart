part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class AddUserEvent extends HomePageEvent {
  final User user;
  AddUserEvent({required this.user});
}

final class GetChatMessagesListEvent extends HomePageEvent {
  final int userID;
  GetChatMessagesListEvent({required this.userID});
}
