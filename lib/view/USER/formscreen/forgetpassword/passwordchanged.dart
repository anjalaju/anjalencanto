import 'package:flutter/material.dart';
import 'package:main_project/view/USER/formscreen/loginpage.dart';

class passdchanged extends StatefulWidget {
  const passdchanged({super.key});

  @override
  State<passdchanged> createState() => _passdchangedState();
}

class _passdchangedState extends State<passdchanged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 146, 204, 1),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 150,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                // color: Colors.red,
            
                child: const Image(
                  image: AssetImage(
                    "images/greenverifi.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
                child: Text(
              "Password Changed",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            )),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                " Your Password has been",
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 217, 217, 217)),
              ),
            ),
              const Center(
                child: Text(
                "changed successfully",
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 217, 217, 217)),
                            ),
              ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.circular(10))),
                      minimumSize: MaterialStateProperty.all(const Size(280, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Colors.black),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 27, 75))),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder:(context) => loginpage()));
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
