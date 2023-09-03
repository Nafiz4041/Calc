import 'package:calc/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userquestion = '';
  var useranswer = '';
  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(156, 0, 0, 0),
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userquestion,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        useranswer,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  //AC button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userquestion = '';
                          useranswer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: Colors.red,
                    );
                  }
                  //DEL button
                  else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userquestion = userquestion.substring(
                              0, userquestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: Colors.red,
                    );
                  }
                  //equal button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed2();
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: Colors.white,
                    );
                  }
                  //percentage button
                  else if (index == buttons.length - 17) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed2();
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: Colors.white,
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userquestion = userquestion.substring(
                              0, userquestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: Colors.red,
                    );
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userquestion = userquestion + buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(39, 43, 51, 100),
                      textColor: isOperator(buttons[index])
                          ? Color.fromRGBO(38, 237, 201, 100)
                          : Colors.white,
                    );
                  }
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed2() {
    String finalquestion = userquestion;
    finalquestion = finalquestion.replaceAll('x', '*');

    // Check for '%' and replace it with '/100'
    if (finalquestion.contains('%')) {
      finalquestion = finalquestion.replaceAll('%', '/100');
    }

    Parser p = Parser();
    Expression exp = p.parse(finalquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    useranswer = eval.toString();
  }
}
