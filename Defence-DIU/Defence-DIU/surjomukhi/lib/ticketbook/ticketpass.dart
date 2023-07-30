import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surjomukhi/errorPages/successful.dart';
import 'package:surjomukhi/views/landing/landing.dart';
import '../groupChat/firebase_service.dart';
import 'ticketBookingPage.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool hasBookedTicket = false;
  String userId = FirebaseService()
      .getCurrentUserId(); // Replace this with the actual user ID from your authentication system

  @override
  void initState() {
    super.initState();
    _checkBookingStatus();
  }

  Future<void> _checkBookingStatus() async {
    try {
      // Retrieve the booking status for the current user from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('ticket')
          .doc(userId)
          .get();

      // Check if the snapshot exists and if the field 'hasBookedTicket' exists
      if (snapshot.exists && snapshot.data() != null) {
        bool hasBookedTicket = snapshot['hasBookedTicket'] ?? false;
        setState(() {
          this.hasBookedTicket = hasBookedTicket;
        });
      } else {
        // If the document does not exist or the field 'hasBookedTicket' does not exist,
        // assume the user has not booked a ticket yet.
        setState(() {
          this.hasBookedTicket = false;
        });
      }
    } catch (e) {
      // Handle any error that occurs during the process
      print('Error checking booking status: $e');
    }
  }

  // Future<void> _checkBookingStatus() async {
  //   // Retrieve the booking status for the current user from Firestore
  //   DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //   bool hasBookedTicket = snapshot['hasBookedTicket'] ?? false;
  //   setState(() {
  //     this.hasBookedTicket = hasBookedTicket;
  //   });
  // }

  Future<void> _bookTicket() async {
    if (!hasBookedTicket) {
      // Navigate to the ticket booking page
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicketBookingPage()),
      );

      // Update the booking status after returning from the ticket booking page
      _checkBookingStatus();
    } else {
      // User has already booked a ticket, show a message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Already Booked'),
          content: Text('You have already booked a ticket.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
                  "Ticket Booking",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(20.0),
              child: Text(
                hasBookedTicket
                    ? 'Thanks For booking Tickets Hope You will go timely in bus-stop !'
                    : 'You have not booked a ticket yet.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000)),
              ),
            ),
            Container(
                height: 250.0,
                child: Image.asset("assets/images/ticketbus.png")),
            GestureDetector(
              onTap: _bookTicket,
              child: Container(
                height: 55.0,
                width: 225.0,
                decoration: BoxDecoration(
                    color: Color(0xFF98EAF3),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        hasBookedTicket ? 'Already Booked' : 'Book Ticket',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF004A54)))),
              ),
            ),
            // ElevatedButton(
            //   onPressed: _bookTicket,
            //   child: Text(hasBookedTicket ? 'Already Booked' : 'Book Ticket'),
            // ),
          ],
        ),
      ),
    );
  }
}
