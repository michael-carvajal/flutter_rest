import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  dynamic joke;
  bool dataLoaded = false;
  bool showPunchline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
      ),
      body: dataLoaded
          ? Center(
              child: Column(
                children: [
                  Text(
                    joke['setup'],
                    style: const TextStyle(fontSize: 48.0),
                    textAlign: TextAlign.center,
                  ),
                  showPunchline
                      ? Text(joke['punchline'],
                          style: const TextStyle(fontSize: 24.0))
                      : Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showPunchline = true;
                                });
                              },
                              child: const Text('Reveal Punchline')))
                ],
              ),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dataLoaded = false;
          showPunchline = false;
          final response = await http.get(
              Uri.parse('https://official-joke-api.appspot.com/random_joke'));
          final body = jsonDecode(response.body);
          // print(body);
          setState(() {
            joke = body;
            dataLoaded = true;
          });
        },
        child: const Text(
          'Get Quote',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
