import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Calculator(), debugShowCheckedModeBanner: false);
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';
  String? operation;
  double? firstNumber;
  bool shouldResetDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final buttonSize = constraints.maxWidth / 5;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      display,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    calcbutton("C", Colors.grey, buttonSize),
                    calcbutton("+/-", Colors.grey, buttonSize),
                    calcbutton("%", Colors.grey, buttonSize),
                    calcbutton("÷", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("7", Colors.white38, buttonSize),
                    calcbutton("8", Colors.white38, buttonSize),
                    calcbutton("9", Colors.white38, buttonSize),
                    calcbutton("×", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("4", Colors.white38, buttonSize),
                    calcbutton("5", Colors.white38, buttonSize),
                    calcbutton("6", Colors.white38, buttonSize),
                    calcbutton("-", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("1", Colors.white38, buttonSize),
                    calcbutton("2", Colors.white38, buttonSize),
                    calcbutton("3", Colors.white38, buttonSize),
                    calcbutton("+", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            onTap: () => onButtonPressed("0"),
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: buttonSize,
                              alignment: Alignment.center,
                              child: const Text(
                                "0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    calcbutton(".", Colors.white38, buttonSize),
                    calcbutton("=", Colors.orange, buttonSize),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget calcbutton(String text, Color bgColor, double size) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            onTap: () => onButtonPressed(text),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: size,
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        firstNumber = null;
        operation = null;
      } else if (buttonText == '+/-') {
        if (display != '0') {
          if (display.startsWith('-')) {
            display = display.substring(1);
          } else {
            display = '-$display';
          }
        }
      } else if (buttonText == '%') {
        final value = double.parse(display);
        display = (value / 100).toString();
      } else if (buttonText == '.') {
        if (!display.contains('.')) {
          display = '$display.';
        }
      } else if (['+', '-', '×', '÷'].contains(buttonText)) {
        firstNumber = double.parse(display);
        operation = buttonText;
        shouldResetDisplay = true;
      } else if (buttonText == '=') {
        if (operation != null && firstNumber != null) {
          final secondNumber = double.parse(display);
          double result;
          switch (operation) {
            case '+':
              result = firstNumber! + secondNumber;
              break;
            case '-':
              result = firstNumber! - secondNumber;
              break;
            case '×':
              result = firstNumber! * secondNumber;
              break;
            case '÷':
              result = firstNumber! / secondNumber;
              break;
            default:
              result = secondNumber;
          }
          display = result.toString();
          if (display.endsWith('.0')) {
            display = display.substring(0, display.length - 2);
          }
          operation = null;
          firstNumber = null;
        }
      } else {
        if (display == '0' || shouldResetDisplay) {
          display = buttonText;
          shouldResetDisplay = false;
        } else {
          display += buttonText;
        }
      }
    });
  }
}
