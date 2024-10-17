import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Commits Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CommitListPage(),
    );
  }
}

class CommitListPage extends StatefulWidget {
  const CommitListPage({super.key});

  @override
  _CommitListPageState createState() => _CommitListPageState();
}

class _CommitListPageState extends State<CommitListPage> {
  List commits = [];

  @override
  void initState() {
    super.initState();
    fetchCommits();
  }

  Future<void> fetchCommits() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/Kikegg97/test_commits_view/commits?per_page=100'),
    );

    if (response.statusCode == 200) {
      setState(() {
        commits = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load commits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commit History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchCommits(); // Llama a la función para actualizar los commits
            },
          ),
        ],
      ),
      body: commits.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: commits.length,
              itemBuilder: (context, index) {
                final commit = commits[index]['commit'];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(commit['author']['name'][0]), // Inicial del autor
                    ),
                    title: Text(commit['message']), // Mensaje del commit
                    subtitle: Text('Author: ${commit['author']['name']}'), // Autor del commit
                    trailing: Text(commit['author']['date'].substring(0, 10)), // Fecha del commit
                  ),
                );
              },
            ),
    );
  }
}
