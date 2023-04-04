import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quizbrain.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int amountOfTrue = 0;
  int amountOfFalse = 0;
  String getResult() {
    if (amountOfFalse > amountOfTrue) {
      return 'Awful.';
    } else if (amountOfTrue == amountOfFalse) {
      return 'Not Bad';
    } else {
      return 'Wonderful!';
    }
  }

  void checkAnswer(bool answer) {
    if (quizBrain.isFinished()) {
      Alert(
        style: const AlertStyle(
          animationType: AnimationType.grow,
          animationDuration: Duration(milliseconds: 1000),
          backgroundColor: Colors.white,
        ),
        context: context,
        title: "GAME OVER",
        desc: getResult(),
        buttons: [
          DialogButton(
            color: Colors.pink.shade500,
            onPressed: () {
              time = 10;
              setState(() {
                quizBrain.reset();
                amountOfTrue = 0;
                amountOfFalse = 0;
              });
              Navigator.pop(context);
            },
            width: 120,
            child: const Text(
              "Play Again!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    } else {
      bool correctAnswer = quizBrain.getAnswer();
      if (correctAnswer == answer) {
        amountOfTrue++;
      } else {
        amountOfFalse++;
      }
      setState(() {
        quizBrain.nextQuestion();
      });
    }
  }

  int time = 10;

  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        setState(() {
          time = 10;
          quizBrain.nextQuestion();
          amountOfFalse++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 60,
                  ),
                  Text(
                    '$amountOfTrue',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 45,
                      lineWidth: 7,
                      percent: (10 - time) / 10,
                      center: Text(
                        '$time',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      progressColor: Colors.orange.shade700,
                      backgroundColor: Colors.orange.shade100,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 60,
                  ),
                  Text(
                    '$amountOfFalse',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quizBrain.getText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                time = 10;
                checkAnswer(true);
              },
              child: const Text('True'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                time = 10;
                checkAnswer(false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('False'),
            ),
          ),
        ),
      ],
    );
  }
}
