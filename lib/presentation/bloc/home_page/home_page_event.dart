part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class AddUserEvent extends HomePageEvent {
  final User user;
  AddUserEvent({required this.user});
}
