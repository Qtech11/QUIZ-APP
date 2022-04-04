import 'package:flutter/material.dart';
import 'question_library.dart';
import 'package:cool_alert/cool_alert.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> ticker = [];

  int questionIndex = 0;

  QuestionLibrary que = QuestionLibrary();

  void button(bool a) {
    bool checkAnswers = que.getQuestionAnswer();
    setState(() {
      if (que.isFinished() == false) {
        if (checkAnswers == a) {
          ticker.add(
            Icon(
              Icons.check,
              color: Colors.green[800],
            ),
          );
        } else {
          ticker.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        que.nextQuestion();
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "You're done with today's question",
            confirmBtnColor: Colors.green,
            backgroundColor: Colors.lightGreen.shade100,
            confirmBtnText: 'ok');
        que.reset();
        ticker = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                que.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.green[900],
              child: TextButton(
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  //The user picked true.
                  button(
                    true,
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.red,
              child: TextButton(
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //The user picked false.
                  button(false);
                },
              ),
            ),
          ),
        ),
        Row(
          children: ticker,
        ),
      ],
    );
  }
}
