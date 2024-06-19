import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Bussines_logic/firebase_options.dart';
import 'package:main_project/controller/AuthProvider.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/controller/paymentcontroller.dart';
import 'package:main_project/usertype.dart';
import 'package:main_project/view/USER/homepage/homepage.dart';
import 'package:main_project/view/admin/charity.dart';
import 'package:main_project/view/admin/drawer.dart';
import 'package:main_project/view/admin/eventsviw_admin.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FunctionProvider()),
        ChangeNotifierProvider(create: (_) => PaymentController())
      ],
      child:  MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home:
       
      //  Drawerpage()
         UserType(),
         
      ),
    );
  }
}
