import 'package:mysivi_task/presentation/models/chat_message_model.dart';

abstract class UsersRepository {
  Future<List<ChatMessage>> getChatMessgaesList(int limit);
}
