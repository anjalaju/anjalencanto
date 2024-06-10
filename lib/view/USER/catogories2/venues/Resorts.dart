import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:main_project/view/USER/booking/booking.dart';
import 'package:main_project/view/USER/chat.dart';
import 'package:main_project/model/addProject.dart';
import 'package:main_project/controller/FunctionProvider.dart';
import 'package:main_project/utils/String.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Resorts extends StatefulWidget {
  const Resorts({super.key});

  @override
  State<Resorts> createState() => _ResortsState();
}

class _ResortsState extends State<Resorts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resorts',
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
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
            Consumer<FunctionProvider>(
              builder: (context, helper, child) {
                return StreamBuilder(
                  stream: helper.getEventproject('Venues', 'Resorts'),
                  builder: (context, snapshot) {

                   if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                   }

                    List<EventModel> list = [];
                    list = snapshot.data!.docs.map((e) {
                      return EventModel.fromJsone(
                          e.data() as Map<String, dynamic>);
                    }).toList();

                    if(snapshot.hasData){
                      return list.isEmpty ? Center(child: Text('no event'),): ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 231,
                                width: 350,
                                child:   Image(
                                  image: NetworkImage(
                                    list[index].Image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBar.builder(
                                itemSize: 25,
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text(list[index].discription),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text(list[index].eventName),
                                        // IconButton(
                                        //     onPressed: () {
                                        //       Navigator.of(context).push(MaterialPageRoute(
                                        //         builder: (context) => Shortlist(),
                                        //       ));
                                        //     },
                                        //     icon: const Icon(Icons.favorite_border)
                                        //     )
                                        LikeButton(
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isLiked
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 30,
                                            );
                                          },
                                          onTap: (bool isLiked) {
                                            return Future.value(!isLiked);
                                          },
                                        ),
                                      ],
                                    ),
                                    const Text("non veg"),
                                    const Text("800 per plate"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Rental cost"),
                                        OutlinedButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all(
                                                    const Color(0xff496FF7)),
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                        const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(200, 50)),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color:
                                                            Color(0xff496FF7))),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    Bookimgpage(eventModel: list[index],),
                                              ));
                                            },
                                            child: const Row(
                                              children: [
                                                Icon(Icons.message),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text("Book now"),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          size: 20,
                                        ),
                                        Text(
                                          list[index].startingPriceFrom,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all(
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => Chatpage(
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
                                        _makePhoneCall('7025053483');
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
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Helper.h(context) * .20,
                        );
                      },
                    );
                
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ),
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
