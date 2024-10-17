import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renk Değiştirme Uygulaması',
      home: ColorChangeScreen(),
    );
  }
}

class ColorChangeScreen extends StatefulWidget {
  @override
  _ColorChangeScreenState createState() => _ColorChangeScreenState();
}

class _ColorChangeScreenState extends State<ColorChangeScreen> {

  Color _backgroundColor = Colors.yellow;


  void _changeColor() {
    setState(() {

      _backgroundColor =
      _backgroundColor == Colors.yellow ? Colors.blue : Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: ElevatedButton(
          onPressed: _changeColor,
          child: Text(
            'Rengi Değiştir',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
