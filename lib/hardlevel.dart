import 'dart:math';
import 'package:flutter/material.dart';

class HardLevel extends StatefulWidget {
  @override
  _HardLevelState createState() => _HardLevelState();
}

class _HardLevelState extends State<HardLevel> {
  @override
  final List<String> words = [
    'STAMP',
    'ASSETS',
    'IMAGES',
    'BUILD',
    'SUBSET',
    'ANDROID',
    'MACOS',
    'LINUX',
    'PLUGINS',
    'PUBSPEC',
    'DEPENDENCIES',
    'WINDOWS',
    'GITIGNORE',
    'INDEX',
    'KOTLIN',
    'CONFIG',
    'DARTPAD',
    'WIDGET',
    'MATERIAL'
  ];
  int score = 0;
  late String wordToGuess;
  late List<String> displayedLetters;
  late List<String> guessedLetters;
  late int remainingGuesses;
  late bool isGameOver;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      wordToGuess = words[Random().nextInt(words.length)];
      displayedLetters = List.generate(wordToGuess.length, (index) => '_');
      guessedLetters = [];
      remainingGuesses = 7;
      isGameOver = false;
      score = 0; // Reset the score to 0
    });
  }

  void guessLetter(String letter) {
    setState(() {
      if (!isGameOver && !guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        if (wordToGuess.contains(letter)) {
          for (int i = 0; i < wordToGuess.length; i++) {
            if (wordToGuess[i] == letter) {
              displayedLetters[i] = letter;
            }
          }
          score += 10; // Add 10 points for correct guess
        } else {
          remainingGuesses--;
          if (remainingGuesses == 0) {
            isGameOver = true;
            score -=
                10; // Deduct 5 points for incorrect guess that exhausts all attempts
          } else {
            score -= 2; // Deduct 2 point for incorrect guess
          }
        }
        if (!displayedLetters.contains('_')) {
          isGameOver = true;
          score += 20; // Add 20 points for winning (BONUS for Hard mode)
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 237, 250),
      appBar: AppBar(
        title: Text('ThinkerMan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayedLetters.join(' '),
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 16),
            Text(
              'Guessed Letters: ${guessedLetters.join(', ')}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Remaining Guesses: $remainingGuesses',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            isGameOver
                ? Column(
                    children: [
                      Text(
                        displayedLetters.contains('_')
                            ? 'You lose! The word was "$wordToGuess".'
                            : 'You win!',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 16),
                      IconButton(
                        onPressed: startNewGame,
                        icon: const Icon(Icons.replay_circle_filled_outlined,
                            size: 36.0),
                      ),
                    ],
                  )
                : GridView.count(
                    crossAxisCount: 6,
                    shrinkWrap: true,
                    children: List.generate(
                      26,
                      (index) => Center(
                        child: ElevatedButton(
                          onPressed: () =>
                              guessLetter(String.fromCharCode(65 + index)),
                          child: Text(String.fromCharCode(65 + index)),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
