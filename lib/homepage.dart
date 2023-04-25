import 'package:flutter/material.dart';
import 'scorepage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 237, 250),
      appBar: AppBar(
        title: const Text('ThinkerMan'),
        leading: IconButton(
          icon: const Icon(Icons.stacked_bar_chart_outlined),
          onPressed: () {
            // Navigate to score screen

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ScorePage(
                        scoreRecord: [10, 105, 77, -10, 0],
                      )), // navigate to score screen
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/flutter_logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Flutter Tech',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                color: Colors.limeAccent[100],
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  iconSize: 50.0,
                  onPressed: () {
                    // Navigate to settings screen
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ),
              Spacer(),
              Container(
                color: Colors.green[100],
                child: IconButton(
                  icon: const Icon(Icons.psychology_alt_outlined),
                  iconSize: 50.0,
                  onPressed: () {
                    // Navigate to game screen
                    Navigator.pushNamed(context, '/game');
                  },
                ),
              ),
              Spacer(),
              Container(
                color: Colors.orange[100],
                child: IconButton(
                  icon: const Icon(Icons.list),
                  iconSize: 50.0,
                  onPressed: () {
                    // Navigate to levels screen
                    Navigator.pushNamed(context, '/level');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
