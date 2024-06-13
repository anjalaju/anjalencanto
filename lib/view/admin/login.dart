import 'package:flutter/material.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('images/logi.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Container(
            width: 500,
            height: 500,
            decoration: const BoxDecoration(
                color: Colors.white,
                image: const DecorationImage(
                    image: AssetImage('images/loginbox.jpg'),
                    fit: BoxFit.cover)),
            child: const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}

// class LogginAdmin extends StatefulWidget {
//   const LogginAdmin({super.key});

//   @override
//   State<LogginAdmin> createState() => _LogginAdminState();
// }

// class _LogginAdminState extends State<LogginAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     final emailControlller = TextEditingController();
//     final passwordController = TextEditingController();

//     final formkey = GlobalKey<FormState>();

//     bool _obscuretext = true;

//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//         child: Form(
//           key: formkey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       flex: 3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height:  Helper.W(context) * .200,
//                           ),
//                           Textwidget(
//                             text: 'EXPENSETRACK ',
//                             style: TextStyle(
//                                 fontSize:Helper.W(context) * .050,
//                                 color: Colors.white),
//                           ),
//                           Textwidget(
//                             text: 'PRO ',
//                             style: TextStyle(
//                               fontSize:Helper.W(context) * .050,
//                               color: Colors.amber,
//                             ),
//                           ),
//                         ],
//                       )),
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: Helper.W(context)  * .200,
//                         ),
//                         Column(
//                           children: [
//                             Textwidget(
//                                 text: 'Sign In now',
//                                 style: TextStyle(
//                                   fontSize:Helper.W(context) * .020,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 )),
//                             Textwidget(
//                                 text: 'Please sign in to continue our app',
//                                 style: TextStyle(
//                                     fontSize:Helper.W(context) * .010,
//                                     color: Colors.white)),
//                           ],
//                         ),
//                         SizedBox(
//                           height:Helper.W(context) * .050,
//                         ),
//                         Container(
//                           width:Helper.W(context) * .280,
//                           height:Helper.W(context) * .540,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(
//                              Helper.W(context) * .020,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal:Helper.W(context) * .020,
//                               vertical:Helper.W(context) * .020,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Textwidget(text: 'Email', style: TextStyle()),
//                                 textformwidget(
//                                   controller: emailControlller,
//                                   validation: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'required';
//                                     }
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height:Helper.W(context) * .030,
//                                 ),
//                                 Textwidget(
//                                     text: 'Password', style: TextStyle()),
//                                 Consumer<controller>(
//                                   builder: (context, instance, _) {
//                                     return TextFormField(
//                                       controller: passwordController,
//                                       obscureText: instance.obscuretext,
//                                       decoration: InputDecoration(
//                                         fillColor: Colors.grey,
//                                         filled: true,
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             instance.toggle();
//                                           },
//                                           icon: instance.obscuretext
//                                               ? Icon(Icons.visibility_off)
//                                               : Icon(Icons.visibility),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                            Helper.W(context) * .010,
//                                           ),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                       ),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'required';
//                                         }
//                                         return null;
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height:Helper.W(context) * .020,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {},
//                                       child: Textwidget(
//                                         text: 'Forgot Password?',
//                                         style:
//                                             TextStyle(color: Colors.greydark),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Containerwidget(
//                                   height:Helper.W(context) * .070,
//                                   width: double.infinity,
//                                   text: 'Log in',
//                                   fontsize:Helper.W(context) * .020,
//                                   ontap: () async {
//                                     if (formkey.currentState!.validate()) {
//                                       await auth
//                                           .signInWithEmailAndPassword(
//                                               email: emailControlller.text,
//                                               password: passwordController.text)
//                                           .then((value) {
//                                         if (value.user!.uid == admin) {
//                                           Navigator.pushAndRemoveUntil(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     AdminHomeScreen(),
//                                               ),
//                                               (route) => false);
//                                           SuccsToast(context, 'Loggin succes');
//                                         } else {
//                                           ErorrToast(context, 'error requred');
//                                         }
//                                       });
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class textformwidget extends StatelessWidget {
//   final IconButton? sufix;
//   final FormFieldValidator<String> validation;
//   final String? hint;
//   final TextEditingController? controller;

//   const textformwidget(
//       {super.key,
//       this.sufix,
//       required this.validation,
//       this.hint,
//       this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hint,
//         fillColor: Colors.grey,
//         filled: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//            Helper.W(context) * .010,
//           ),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       validator: validation,
//     );
//   }
// }
























                        