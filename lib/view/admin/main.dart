
import 'package:flutter/material.dart';
import 'package:main_project/view/admin/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encanto Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Login(),
      home: Drawerpage(),
      // home: EventDashboard(),
      // home: Userdetails(),
      // home: Entrepreneurdetails(),
      // home: NotificationPgae(),
    );
  }
}
