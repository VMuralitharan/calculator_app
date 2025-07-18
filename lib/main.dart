import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.all(9),
                      height: size,
                      width: size,
                      alignment: Alignment.center,
                      child: Text(
                        "7",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.all(9),
                      height: size,
                      width: size,
                      alignment: Alignment.center,
                      child: Text(
                        "8",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.all(9),
                      height: size,
                      width: size,
                      alignment: Alignment.center,
                      child: Text(
                        "9",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.all(9),
                      height: size,
                      width: size,
                      alignment: Alignment.center,
                      child: Text(
                        "/",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
