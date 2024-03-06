import 'package:flutter/material.dart';
import 'package:flutter_rest/services/users_api.dart';

import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  bool isLoading = false; // Track loading state
  bool dataLoaded = false; // Track whether data has been loaded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber[500],
        shadowColor: Colors.amber[900],
        title: const Text('Rest Api Call'),
      ),
      body: Center(
        child: dataLoaded
            ? buildUserListView() // Show ListView if data is loaded
            : buildWelcomeMessage(), // Show welcome message otherwise
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData(); 
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget buildWelcomeMessage() {
    return const Text('Welcome to the App!');
  }

  Widget buildUserListView() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final email = user.email;

        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(user.picture['thumbnail']),
          ),
          title: Text(email),
        );
      },
    );
  }

  void fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true; // Set loading state to true
      });
      final response = await UserApi.fetchUsers();
      setState(() {
        users = response;
        dataLoaded = true; // Set dataLoaded to true when data is loaded
        isLoading = false; // Set loading state to false
      });
    }
  }
}


  // void fetchUsers() async {
  //   print('fetch users found');
  //   const url = 'https://randomuser.me/api/?results=100';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final body = response.body;
  //   final json = jsonDecode(body);
  //   final results = json['results'] as List<dynamic>;
  //   final transformed = results.map((user) {
  //     return User(
  //       cell: user['cell'],
  //       email: user['email'],
  //       phone: user['phone'],
  //       nat: user['nat'],
  //       gender: user['gender'],
  //       picture: user['picture'],
  //     );
  //   }).toList();
  //   setState(() {
  //     users = transformed;
  //   });
  // }
