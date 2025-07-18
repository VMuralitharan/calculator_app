import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          // Use LayoutBuilder to safely get dimensions
          builder: (context, constraints) {
            final buttonSize =
                constraints.maxWidth /
                5; // Calculate button size based on screen width
            return Column(
              children: [
                Row(
                  children: [
                    calcbutton("7", Colors.white38, buttonSize),
                    calcbutton("8", Colors.white38, buttonSize),
                    calcbutton("9", Colors.white38, buttonSize),
                    calcbutton("/", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("7", Colors.white38, buttonSize),
                    calcbutton("8", Colors.white38, buttonSize),
                    calcbutton("9", Colors.white38, buttonSize),
                    calcbutton("/", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("7", Colors.white38, buttonSize),
                    calcbutton("8", Colors.white38, buttonSize),
                    calcbutton("9", Colors.white38, buttonSize),
                    calcbutton("/", Colors.orange, buttonSize),
                  ],
                ),
                Row(
                  children: [
                    calcbutton("7", Colors.white38, buttonSize),
                    calcbutton("8", Colors.white38, buttonSize),
                    calcbutton("9", Colors.white38, buttonSize),
                    calcbutton("/", Colors.orange, buttonSize),
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
    return Container(
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
        style: const TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
