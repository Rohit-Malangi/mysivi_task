import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:meta/meta.dart';
import 'package:mysivi_task/domain/repository/users_repository.dart';
import 'package:mysivi_task/presentation/models/chat_message_model.dart';
import 'package:mysivi_task/presentation/models/user_model.dart';
import 'package:mysivi_task/utils/gen_random.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UsersRepository userRepository;

  final List<User> _users = [];
  final List<User> _chatUsers = [];

  List<User> get getUsersList => _users;
  List<User> get getChatUserList => _chatUsers;

  HomePageBloc({required this.userRepository}) : super(HomePageInitial()) {
    on<AddUserEvent>(_addUser);
    on<GetChatMessagesListEvent>(_getChatMessagesList);
  }

  void sortUser() {
    _chatUsers.sort((a, b) {
      if (a.isOnline && b.isOnline) return a.name.compareTo(b.name);
      if (a.isOnline && !b.isOnline) return -1;
      if (!a.isOnline && b.isOnline) return 1;
      return b.onlineTime!.compareTo(a.onlineTime!);
    });
  }

  void _addUser(AddUserEvent event, Emitter<HomePageState> emit) {
    _users.insert(0, event.user);

    if (event.user.lastMsg != null && event.user.lastMsg!.isNotEmpty) {
      _chatUsers.add(event.user);
      sortUser();
    }

    emit(UserAddedState());
  }

  void _getChatMessagesList(
    GetChatMessagesListEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(GetChatMessagesListLoadingState(isLoading: true));
    try {
      await userRepository
          .getChatMessgaesList(GenerateRandom.randomIntTillN(30))
          .then((value) {
            value.sort((a, b) => a.time.isBefore(b.time) ? -1 : 1);
            User user = _users.firstWhereOrNull(
              (e) => e.userID == event.userID,
            )!;
            user.lastMsg = value.last.text;
            User? chatUser = _chatUsers.firstWhereOrNull(
              (e) => e.userID == event.userID,
            );
            if (chatUser == null) {
              _chatUsers.add(user);
              sortUser();
            } else {
              chatUser.lastMsg = value.last.text;
            }
            emit(GetChatMessagesListState(list: value));
          });
    } catch (e) {
      emit(HomePageErrorState(msg: e.toString()));
    }
    emit(GetChatMessagesListLoadingState(isLoading: false));
  }
}
