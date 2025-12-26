import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final List<User> _users = [];
  final List<User> _chatUsers = [];

  List<User> get getUsersList => _users;
  List<User> get getChatUserList => _chatUsers;

  HomePageBloc() : super(HomePageInitial()) {
    on<AddUserEvent>(_addUser);
  }

  void _addUser(AddUserEvent event, Emitter<HomePageState> emit) {
    _users.insert(0, event.user);

    _chatUsers.add(event.user);

    if (event.user.lastMsg != null && event.user.lastMsg!.isNotEmpty) {
      _chatUsers.sort((a, b) {
        if (a.isOnline && b.isOnline) return a.name.compareTo(b.name);
        if (a.isOnline && !b.isOnline) return -1;
        if (!a.isOnline && b.isOnline) return 1;
        return b.onlineTime!.compareTo(a.onlineTime!);
      });
    }

    emit(UserAddedState());
  }
}
