import 'package:flutter/material.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:main_project/view/USER/chat.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Receivedecor extends StatefulWidget {
  const Receivedecor({super.key});

  @override
  State<Receivedecor> createState() => _ReceivedecorState();
}

class _ReceivedecorState extends State<Receivedecor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Decoration items',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 2,
            color: Colors.black,
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<FunctionProvider>(
              builder: (context, helper, child) {
                final data = helper.donted;

                return FutureBuilder(
                  future: helper.getallDonated('Decorationitems',),
                  builder: (context, snapshot) {
                    return
                    data.isEmpty?SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'images/no charity.jpeg'))),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 150.0),
                                  child: Center(
                                      child: Text(
                                    "No Charity",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ))),
                      ):

                    
                     ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: SizedBox(
                                height: 320,
                                width: 240,
                                // color: Colors.amber,
                                child: Image(
                                  image: NetworkImage(
                                  data[index].image ,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(data[index].name),
                            Text("Age : ${data[index].age}"),
                            Text(data[index].place),
                            Text("Number of items : ${data[index].numberofitem}"),
                            Text("Contact Number : ${data[index].contactnumber}"),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xffFF004D)),
                                          textStyle: MaterialStateProperty.all(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)),
                                          minimumSize: MaterialStateProperty.all(
                                              const Size(250, 50)),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Color(0xffFF004D))),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)))),
                                      onPressed: () {
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) => Chatpage(
                                        //     name: 'Decoration items',
                                        //   ),
                                        // ));
                                          String phoneNumber = data[index].contactnumber;
                                        String message =
                                            "Dear Sir/Madam";
                                        String url =
                                            "sms:$phoneNumber?body=$message";
                                        launch(url);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.message),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("Message"),
                                        ],
                                      )),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff63C336)),
                                      textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(30, 50)),
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Color(0xff63C336)),
                                      ),
                                    ),
                                    onPressed: () {
                                      _makePhoneCall(data[index].contactnumber);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.call),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Helper.h(context) * .050,
                        );
                      },
                    );
                  },
                );
              },
            )),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
