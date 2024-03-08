import 'package:flutter/material.dart';
import 'package:flutter_rest/screen/second_screen.dart';
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
        actions: [
          IconButton(
            icon: Icon(dataLoaded ? Icons.home : Icons.refresh),
            onPressed: () {
              toggleData();
            },
          ),
        ],
      ),
      body: Center(
        child: dataLoaded ? buildUserListView() : buildWelcomeMessage(),
      ),
    );
  }

  Widget buildWelcomeMessage() {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecondScreen()));
        },
        child: const Text("To Second Page screen"));
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

  void toggleData() {
    if (dataLoaded) {
      setState(() {
        dataLoaded = false; // Set dataLoaded to false to show welcome message
      });
    } else {
      fetchData(); // Fetch data if not already loaded
    }
  }
}
