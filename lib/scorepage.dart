import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final List<int> scoreRecord;

  const ScorePage({
    Key? key,
    required this.scoreRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Record'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: scoreRecord.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Game ${index + 1} - Score: ${scoreRecord[index]}'),
          );
        },
      ),
    );
  }
}
