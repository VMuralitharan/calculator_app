import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = constraints.maxWidth / 5;
          return Column(
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                height: constraints.maxHeight / 3,
                child: Text(
                  display,
                  style: const TextStyle(color: Colors.white, fontSize: 80),
                ),
              ),
              // Rest of your button rows...
              Row(
                children: [
                  calcbutton("7", Colors.white38, buttonSize),
                  calcbutton("8", Colors.white38, buttonSize),
                  calcbutton("9", Colors.white38, buttonSize),
                  calcbutton("÷", Colors.orange, buttonSize),
                ],
              ),
              Row(
                children: [
                  calcbutton("4", Colors.white38, buttonSize),
                  calcbutton("5", Colors.white38, buttonSize),
                  calcbutton("6", Colors.white38, buttonSize),
                  calcbutton("×", Colors.orange, buttonSize),
                ],
              ),
              Row(
                children: [
                  calcbutton("1", Colors.white38, buttonSize),
                  calcbutton("2", Colors.white38, buttonSize),
                  calcbutton("3", Colors.white38, buttonSize),
                  calcbutton("-", Colors.orange, buttonSize),
                ],
              ),
              Row(
                children: [
                  calcbutton("0", Colors.white38, buttonSize),
                  calcbutton(".", Colors.white38, buttonSize),
                  calcbutton(
                    "=",
                    const Color.fromARGB(255, 5, 113, 9),
                    buttonSize,
                  ),
                  calcbutton("+", Colors.orange, buttonSize),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget calcbutton(String text, Color bgColor, double size) {
    return GestureDetector(
      onTap: () => onButtonPressed(text),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: const EdgeInsets.all(9),
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
      } else if (display == '0') {
        display = buttonText;
      } else {
        display += buttonText;
      }
    });
  }
}
