import 'package:flutter/material.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key});

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.indigo,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('10', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
