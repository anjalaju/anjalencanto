import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingCalendarPage extends StatefulWidget {
  BookingCalendarPage({super.key, required this.id, required this.audname});
  String id;
  String audname;
  @override
  _BookingCalendarPageState createState() => _BookingCalendarPageState();
}

class _BookingCalendarPageState extends State<BookingCalendarPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<DateTime, List> _bookings = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    final userId = auth.currentUser!.uid;
    final snapshot = await db
        // .collection('BookingEvent')
        // .where('Userid', isEqualTo: userId)
        // .get();
        .collection('BookingEvent')
        // .where('Userid', isEqualTo: userId)
        .where('Eventid', isEqualTo: widget.id)
        .get();

    Map<DateTime, List> bookings = {};
    for (var doc in snapshot.docs) {
      DateTime date = DateFormat('dd-MM-yyyy').parse(doc['Data']);
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);
      bookings[normalizedDate] = [doc.data()];
    }

    setState(() {
      _bookings = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 2, color: Colors.indigo)),
                      child: Text("Auditorium Name : ${widget.audname}")),
                ],
              ),SizedBox(height: 20,),
              TableCalendar(
                rowHeight: 65,
                daysOfWeekHeight: 60,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week',
                },
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: DateTime.now(),
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    DateTime normalizedDate =
                        DateTime(date.year, date.month, date.day);
                    if (_bookings[normalizedDate] != null) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
