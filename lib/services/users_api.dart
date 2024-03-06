import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserApi {
  static Future<List<User>> fetchUsers() async {
    print('fetch users found');
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((user) {
      return User(
        cell: user['cell'],
        email: user['email'],
        phone: user['phone'],
        nat: user['nat'],
        gender: user['gender'],
        picture: user['picture'],
      );
    }).toList();
    print('fetch users is working');
    return users;
  }
}
