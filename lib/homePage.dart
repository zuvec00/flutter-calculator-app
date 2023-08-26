import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'utils/buttons.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  userAnswerFunc() {
    Parser ans = Parser();
    Expression exp = ans.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval;
  }

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(userQuestion,
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                        Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child: Text(userAnswer,
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                      ]))),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemCount: buttons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //clear button
                                  if (index == 0) {
                                    return MyButtons(
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        buttonText: buttons[index],
                                        buttonTapped: () {
                                          setState(() {
                                            userQuestion = '';
                                            userAnswer = '';
                                          });
                                        });
                                  }
                                  //delete button
                                  else if (index == 1) {
                                    return MyButtons(
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        buttonText: buttons[index],
                                        buttonTapped: () {
                                          setState(() {
                                            userQuestion =
                                                userQuestion.substring(
                                                    0, userQuestion.length - 1);
                                          });
                                        });
                                  }
                                  //equal button
                                  else if (index == buttons.length - 1) {
                                    return MyButtons(
                                        color: isOperator(buttons[index])
                                            ? Colors.deepPurple
                                            : Colors.deepPurple[50]!,
                                        textColor: isOperator(buttons[index])
                                            ? Colors.white
                                            : Colors.deepPurple,
                                        buttonText: buttons[index],
                                        buttonTapped: () {
                                          
                                            setState(() {
                                              userAnswer =
                                                  userAnswerFunc().toString();
                                          });
                                        });
                                  } else {
                                    return MyButtons(
                                        color: isOperator(buttons[index])
                                            ? Colors.deepPurple
                                            : Colors.deepPurple[50]!,
                                        textColor: isOperator(buttons[index])
                                            ? Colors.white
                                            : Colors.deepPurple,
                                        buttonText: buttons[index],
                                        buttonTapped: () {
                                          setState(() {
                                            userQuestion += buttons[index];
                                          });
                                        });
                                  }
                                })),
                      ))
                ],
              ),
            )));
  }
}

bool isOperator(String x) {
  if (x == '%' || x == '/' || x == '*' || x == '+' || x == '-' || x == '=') {
    return true;
  }
  return false;
}
