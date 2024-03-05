import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;
            // final name = user.emai;
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                // child: Image.network(user['picture']['thumbnail']),
              ),
              title: Text(email),
              // subtitle: Text(name['first']),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async {
    print('fetch users found');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((user) {
      return User(
        cell: user['cell'],
        email: user['email'],
        phone: user['phone'],
        nat: user['nat'],
        gender: user['gender'],
      );
    }).toList();
    setState(() {
      users = transformed;
    });
  }
}
