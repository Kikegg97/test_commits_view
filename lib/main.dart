import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commit History'),
      ),
      body: const Center(
        child: Text('Loading commits...'),
      ),
    );
  }
}
