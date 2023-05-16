import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  final List<String> words = [
    'APP',
    'IOS',
    'LIB',
    'WEB',
    'XML',
    'LOGS',
    'TEST',
    'LOCK',
    'YAML',
    'HTML',
    'JSON',
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
    'SDK',
    'VCS',
    'BIN',
    'JAR',
    'PNG',
    'JPG',
    'ICONS',
    'DART',
    'INFO',
    'IDEA',
    'DILL',
    'PATH',
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
  late String wordToGuess = ' ';
  late List<String> displayedLetters = [];
  late List<String> guessedLetters = [];
  late int remainingGuesses = 0;
  late bool isGameOver = false;

  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  late String spokenWord = ' ';

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    startNewGame();
  }

  String getWord() {
    var random = Random();
    return words[random.nextInt(words.length)];
  }

  void checkAnswer() {
    if (!isGameOver && isListening) {
      final cleanedSpokenWord = spokenWord.trim().toLowerCase();
      final cleanedWordToGuess = wordToGuess.trim().toLowerCase();

      if (cleanedSpokenWord == cleanedWordToGuess) {
        setState(() {
          score += 10;
          for (int i = 0; i < wordToGuess.length; i++) {
            if (displayedLetters[i] == '_') {
              displayedLetters[i] = wordToGuess[i];
            }
          }
        });

        if (!displayedLetters.contains('_')) {
          setState(() {
            isGameOver = true;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      startNewGame();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else if (cleanedSpokenWord == 'quit') {
        setState(() {
          isGameOver = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void startGame() async {
    bool available = await speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      if (isListening) {
        speech.listen(onResult: (val) {
          print('onResult: ${val.recognizedWords}');
          setState(() {
            spokenWord = val.recognizedWords;
            checkAnswer();
          });
        });
      } else {
        speech.stop();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    speech.stop();
  }

  void startNewGame() {
    setState(() {
      wordToGuess = getWord();
      displayedLetters = List.generate(wordToGuess.length, (index) => '_');
      guessedLetters = [];
      remainingGuesses = 10;
      isGameOver = false;
      score = 0;
      spokenWord = '';
    });
  }

  void toggleListening() {
    setState(() {
      isListening = !isListening;
    });
    if (isListening) {
      startGame();
    } else {
      speech.stop();
    }
  }

  void guessLetter(String letter) {
    if (isGameOver) {
      return; // ถ้าเกมสิ้นสุดลงแล้ว ไม่ต้องทำอะไรเพิ่มเติม
    }

    setState(() {
      if (!isGameOver && !guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        if (wordToGuess.contains(letter)) {
          for (int i = 0; i < wordToGuess.length; i++) {
            if (wordToGuess[i] == letter) {
              displayedLetters[i] = letter;
            }
          }
          score += 10; // เพิ่มคะแนน 10 คะแนนสำหรับการเดาถูกต้อง
        } else {
          remainingGuesses--;
          if (remainingGuesses == 0) {
            isGameOver = true;
            score -= 5; // หักคะแนน 5 คะแนนสำหรับการเดาผิดที่ใช้งานครบทุกครั้ง
          } else {
            score -= 1; // หักคะแนน 1 คะแนนสำหรับการเดาผิด
          }
        }
        if (!displayedLetters.contains('_')) {
          isGameOver = true;
          score += 50; // เพิ่มคะแนน 50 คะแนนสำหรับการชนะ
        }
      }
      if (isGameOver) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame(); // เริ่มเกมใหม่
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 237, 250),
      appBar: AppBar(
        title: Text('ThinkerMan'),
        actions: [
          IconButton(
            icon: Icon(isListening ? Icons.mic : Icons.mic_none,
                color: isListening ? Colors.red : Colors.white),
            onPressed: () {
              setState(() {
                isListening = !isListening;
              });
              startGame();
            },
          ),
        ],
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
            Text(
              'Spoken Word: ${spokenWord.split('').join(' ')}',
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
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          10, // Change this value to change the number of columns
                    ),
                    shrinkWrap:
                        true, // Set this to true to prevent the GridView from taking up the entire screen
                    itemCount: 26,
                    itemBuilder: (context, index) {
                      final letter = String.fromCharCode(65 + index);
                      return Center(
                        child: ElevatedButton(
                          onPressed: () => guessLetter(letter),
                          child: Text(letter),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
