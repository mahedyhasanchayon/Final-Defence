import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget {
  // Function to reset all users' ticket booking status
  Future<void> _resetTicketBookingStatus(BuildContext context) async {
    try {
      // Get all users from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ticket').get();

      List<Future<void>> deletes = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        deletes.add(documentSnapshot.reference.delete());
      }
      // Update the booking status for all users
      // List<Future<void>> updates = [];
      // for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      //   updates
      //       .add(documentSnapshot.reference.update({'hasBookedTicket': false}));
      // }
      await Future.wait(deletes);

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Ticket booking status has been reset for all users.'),
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
    } catch (e) {
      // Handle any error that occurs during the process
      print('Error resetting ticket booking status: $e');
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
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8.0),
                Text(
                  "Admin Page",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ticket').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final ticketBookings = snapshot.data!.docs;
          Map<String, Map<String, int>> routeTimeCounts = {};

          // Count the tickets for each route and time
          for (var booking in ticketBookings) {
            final routeFrom = booking['routeFrom'] as String;
            final time = booking['time'] as String;

            if (!routeTimeCounts.containsKey(routeFrom)) {
              routeTimeCounts[routeFrom] = {};
            }

            if (!routeTimeCounts[routeFrom]!.containsKey(time)) {
              routeTimeCounts[routeFrom]![time] = 1;
            } else {
              routeTimeCounts[routeFrom]![time] =
                  routeTimeCounts[routeFrom]![time]! + 1;
            }
          }

          return ListView.builder(
              itemCount: routeTimeCounts.length,
              itemBuilder: (context, index) {
                String routeFrom = routeTimeCounts.keys.elementAt(index);
                Map<String, int> timeCounts = routeTimeCounts[routeFrom]!;

                return Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      color: Color(0xffD9E3DA),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          routeFrom,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              letterSpacing: 2.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: timeCounts.entries.map((entry) {
                            String time = entry.key;
                            int count = entry.value;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  '$time : $count tickets',
                                  style: GoogleFonts.openSans(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      letterSpacing: 2.0),
                                ),
                                SizedBox(
                                  height: 2.0,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _resetTicketBookingStatus(
            context), // Pass the context to the function
        child: Icon(Icons.delete),
      ),
    );
  }
}
