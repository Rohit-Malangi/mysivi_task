import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mysivi_task/domain/repository/users_repository.dart';
import 'package:mysivi_task/presentation/models/chat_message_model.dart';
import 'package:mysivi_task/utils/gen_random.dart';

class UserRepositoryImpl implements UsersRepository {
  @override
  Future<List<ChatMessage>> getChatMessgaesList(int limit) async {
    try {
      final url = Uri.parse('https://dummyjson.com/comments?limit=$limit');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['comments'];
        return data
            .map(
              (e) => ChatMessage(
                text: e['body'],
                isSender: GenerateRandom.randomBool(),
                time: GenerateRandom.generateRandomPastTime(),
              ),
            )
            .toList();
      } else {
        throw Exception('Unable to fetch the messages');
      }
    } catch (e) {
      rethrow;
    }
  }
}
