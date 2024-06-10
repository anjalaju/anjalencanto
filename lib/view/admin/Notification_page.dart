import 'package:flutter/material.dart';

class NotificationPgae extends StatelessWidget {
  const NotificationPgae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 350),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 222, 177, 177),
          ),
        )
      ],
    ));
  }
}
