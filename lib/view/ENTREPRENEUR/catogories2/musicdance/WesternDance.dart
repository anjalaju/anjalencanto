import 'package:flutter/material.dart';
import 'package:main_project/view/ENTREPRENEUR/Entrechat.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Entrepwesterndan extends StatefulWidget {
  const Entrepwesterndan({super.key});

  @override
  State<Entrepwesterndan> createState() => _EntrepwesterndanState();
}

class _EntrepwesterndanState extends State<Entrepwesterndan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Western Dance',
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
        ),
        body: Consumer<FunctionProvider>(
          builder: (context, instance, child) {
            return StreamBuilder(
              stream: instance.getEventproject('Music dance', 'Western dance'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<EventModel> list = [];
                list = snapshot.data!.docs.map((e) {
                  return EventModel.fromJsone(e.data() as Map<String, dynamic>);
                }).toList();
                if (snapshot.hasData) {
                  return list.isEmpty
                      ? Center(
                          child: Text('no data'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9D9D9),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: ("  Search Venues..."),
                                prefixIcon: const Icon(Icons.search),
                              ),
                            ),
                            ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 231,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: list[index].Image.isEmpty
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Image(
                                                  image: NetworkImage(
                                                    list[index].Image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(list[index].eventName),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(list[index].eventPlace),
                                                  IconButton(
                                                      onPressed: () async {
                                                        // await _showMyDialog(
                                                        //   list[index],
                                                        // );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(list[index].discription),
                                                  IconButton(
                                                      onPressed: () {
                                                        // editbootmsheet(
                                                        //     list[index]);
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.currency_rupee,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    list[index]
                                                        .startingPriceFrom,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              // Text("500-700 max")
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                  style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty.all(
                                                              const Color(
                                                                  0xffFF004D)),
                                                      textStyle:
                                                          MaterialStateProperty.all(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14)),
                                                      minimumSize: MaterialStateProperty.all(
                                                          const Size(250, 50)),
                                                      side: MaterialStateProperty.all(
                                                          const BorderSide(
                                                              color:
                                                                  Color(0xffFF004D))),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntreChatpage(
                                                        name: 'Banquet Halls',
                                                      ),
                                                    ));
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
                                                          const Color(
                                                              0xff63C336)),
                                                  textStyle:
                                                      MaterialStateProperty.all(
                                                    const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          const Size(30, 50)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const CircleBorder(),
                                                  ),
                                                  side:
                                                      MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color:
                                                            Color(0xff63C336)),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _makePhoneCall(
                                                      list[index].phonenumber);
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
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 40,
                                );
                              },
                            ),
                          ],
                        ));
                }
                return Container();
              },
            );
          },
        ));
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
