import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surjomukhi/groupChat/firebase_service.dart';

import '../views/landing/landing.dart'; // Replace with your Ticket class if you have one

class TicketBookingPage extends StatefulWidget {
  @override
  _TicketBookingPageState createState() => _TicketBookingPageState();
}

class _TicketBookingPageState extends State<TicketBookingPage> {
  final List<String> routes = ['Mirpur', 'Dhanmondi', 'Tongi', 'Savar'];
  String selectedRoute = 'Mirpur';
  final List<String> times = ['7.00am', '8.00am', '10.00am', '11.00am'];
  String selectedTime = '7.00am';
  final String fixedDestination =
      'DIU Smart City'; // Fixed value for destination
  String userId = FirebaseService()
      .getCurrentUserId(); // Replace this with the actual user ID from your authentication system

  void _submitBooking() async {
    // Save the booking details for the current user to Firestore
    await FirebaseFirestore.instance.collection('ticket').doc(userId).set({
      'userId': userId,
      'routeFrom': selectedRoute,
      'routeTo': fixedDestination,
      'time': selectedTime,
      'hasBookedTicket': true,
    });

    // Show a confirmation dialog or navigate to a success page
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ticket Booking'),
        content: Text('Your ticket has been booked successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  ));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Color.fromARGB(
                  255, 248, 250, 250), // Background color of AppBar
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0), // Rounded bottom corners
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Add logic to handle back navigation if needed
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                ),
                SizedBox(width: 8.0),
                Text(
                  "Book Your Ticket",
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 169, 238, 241),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/bus.png"),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Book Your Ticket",
                          style: GoogleFonts.roboto(
                              fontSize: 25.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              thickness: 2,
                              color: Color(0xFFFF9400),
                            )),
                        SizedBox(
                          height: 35.0,
                        ),
                        Text(
                          "From",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Color(0xFF006371),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedRoute,
                          onChanged: (newValue) {
                            setState(() {
                              selectedRoute = newValue!;
                            });
                          },
                          items: routes.map((route) {
                            return DropdownMenuItem<String>(
                              value: route,
                              child: Text(route),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "To",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Color(0xFF006371),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField<String>(
                          value: fixedDestination,
                          onChanged: (newValue) {
                            // No need to set state, as the value is fixed
                          },
                          items: [
                            DropdownMenuItem(
                                value: fixedDestination,
                                child: Text(fixedDestination))
                          ],
                          decoration: InputDecoration(
                            labelText: 'Destination',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Time",
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Color(0xFF006371),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedTime,
                          onChanged: (newValue) {
                            setState(() {
                              selectedTime = newValue!;
                            });
                          },
                          items: times.map((time) {
                            return DropdownMenuItem<String>(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 70.0),
                        Container(
                          width: double.infinity,
                          height: 55.0,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF98EAF3))),
                              onPressed: _submitBooking,
                              child: Text(
                                "Submit",
                                style: GoogleFonts.roboto(
                                    fontSize: 16.0,
                                    color: Color(0xFF004A54),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
