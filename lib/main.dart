import 'package:flutter/material.dart';
import 'package:math_expression/math_expression.dart';





main() {
  runApp(RootWidget());
}

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'calculator', home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String equation = '0';
  String result = '0';
  String expression = '0';

  buttonPressed(buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');

        try{
          Parser p=Parser();
          Expression exp=p .parse(expression);

          ContextModel cm =ContextModel();
          result='${exp.evaluate(EvaluationType.REAL,)}';
          catch(e){
            result='Error';
          } }


      } else if (buttonText == '⌫') {
        var oldEquation = equation;
        // print(oldEquation.length);
        equation = oldEquation.substring(0, oldEquation.length - 1);
        if (oldEquation == '') {
          equation = '0';
        }
      } else {
        //equation=buttonText;
        var newEquation = equation + buttonText;
        equation = newEquation;
      }
    });
  }

  Widget keyPadButton(buttonText, buttonColor) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget operatorButton(buttonText) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.blue,
          shape: CircleBorder()),
      onPressed: () {
        buttonPressed(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget deleteButton(buttonText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 38, 53, 1),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: EdgeInsets.all(20),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '12+7',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keyPadButton('=', Colors.cyan),
                        keyPadButton('C', Colors.cyan),
                        deleteButton('⌫')
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keyPadButton('7', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('8', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('9', Color.fromRGBO(40, 51, 73, 1)),
                        operatorButton('+'),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keyPadButton('4', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('5', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('6', Color.fromRGBO(40, 51, 73, 1)),
                        operatorButton('-'),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keyPadButton('1', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('2', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('3', Color.fromRGBO(40, 51, 73, 1)),
                        operatorButton('x'),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keyPadButton('0', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('00', Color.fromRGBO(40, 51, 73, 1)),
                        keyPadButton('.', Color.fromRGBO(40, 51, 73, 1)),
                        operatorButton('/'),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                )
              ])),
        ),
      ),
    );
  }
}
