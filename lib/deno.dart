import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}


class _MyWidgetState extends State<MyWidget> {
  Color _iconColor = Colors.grey; // Initial color

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite, color: _iconColor),
      onPressed: () {
        setState(() {
          _iconColor = _iconColor == Colors.grey ? Colors.red : Colors.grey;
        });
      },
    );
  }
}
  String email = " ", password = "";
