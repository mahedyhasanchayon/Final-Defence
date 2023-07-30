import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surjomukhi/groupChat/firebase_service.dart';
import 'package:surjomukhi/ticketbook/ticketpass.dart';
import '../config/config.dart';
import '../styles/button.dart';
import '../styles/color.dart';

class homePageOption extends StatefulWidget {
  homePageOption({super.key});

  @override
  State<homePageOption> createState() => _homePageOptionState();
}

class _homePageOptionState extends State<homePageOption> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DIU Smart Transport System",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        shadowColor: Color.fromARGB(50, 184, 208, 249),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: Image.asset("assets/images/bus.png")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              "assets/images/user.png",
            ),
          ),
          // AssetImage("assets/images/avatar_image.png")
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 20.0, 0, 0),
                  child: Text("Hello, " + userStudentName ?? "")),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 5.0, 0, 0),
                  child: Text("Upcoming Travel",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.sen(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 0, 0, 0)))),
              Container(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                        height: 140.0,
                        width: 300.0,
                        child: Image(
                          image: AssetImage(
                            "assets/images/ticket.png",
                          ),
                          fit: BoxFit.fill,
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 170, 63),
                        child: Text("From")),
                    Padding(
                        padding: EdgeInsets.fromLTRB(170, 0, 0, 63),
                        child: Text("DSC")),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 70, 170, 0),
                        child: Text("Date")),
                    Padding(
                        padding: EdgeInsets.fromLTRB(170, 70, 0, 0),
                        child: Text("Time"))
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 55.0,
                  width: 325.0,
                  child: ElevatedButton(
                    style: buttonPrimary,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketScreen())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.airport_shuttle_outlined),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Purchase Your Ticket Now !!!")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Destination",
                              style: GoogleFonts.sen(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ))),
                    SizedBox(
                      height: 5.0,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Card(
                            color: fogwhite,
                            child: Column(
                              children: [
                                Container(
                                  height: 170,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/mirpur.png"))),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "Mirpur & ECB",
                                  style: GoogleFonts.sen(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )),
                        Card(
                            color: fogwhite,
                            child: Column(
                              children: [
                                Container(
                                  height: 170,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/dhanmondi.png"))),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "Dhanmondi",
                                  style: GoogleFonts.sen(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )),
                        Card(
                            color: fogwhite,
                            child: Column(
                              children: [
                                Container(
                                  height: 170,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/tongi.png"))),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "tongi",
                                  style: GoogleFonts.sen(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )),
                        Card(
                            color: fogwhite,
                            child: Column(
                              children: [
                                Container(
                                  height: 170,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/savar.png"))),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "savar",
                                  style: GoogleFonts.sen(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
