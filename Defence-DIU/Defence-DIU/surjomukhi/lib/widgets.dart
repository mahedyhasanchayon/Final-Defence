import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surjomukhi/styles/button.dart';
import 'package:surjomukhi/styles/color.dart';

Column HomePageOption() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: EdgeInsets.fromLTRB(25.0, 20.0, 0, 0),
          child: Text("Hello Smith",
              textAlign: TextAlign.start,
              style: GoogleFonts.sen(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF899AA1)))),
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
                child: Text("ECB")),
            Padding(
                padding: EdgeInsets.fromLTRB(170, 0, 0, 63),
                child: Text("DSC")),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 70, 170, 0),
                child: Text("23 May 2023")),
            Padding(
                padding: EdgeInsets.fromLTRB(170, 70, 0, 0),
                child: Text("7.00 am"))
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
            onPressed: () {},
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
                                  image:
                                      AssetImage("assets/images/mirpur.png"))),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Mirpur & ECB",
                          style: GoogleFonts.sen(
                              fontSize: 20, fontWeight: FontWeight.w800),
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
                              fontSize: 20, fontWeight: FontWeight.w800),
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
                                  image:
                                      AssetImage("assets/images/uttara.png"))),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Uttara",
                          style: GoogleFonts.sen(
                              fontSize: 20, fontWeight: FontWeight.w800),
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
  );
}

Column ticketPageOption() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("BUY TICKETS",
          textAlign: TextAlign.start,
          style: GoogleFonts.sen(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF899AA1))),
    ],
  );
}

Column buslocationPageOption() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Your Bus Location msg",
          textAlign: TextAlign.start,
          style: GoogleFonts.sen(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF899AA1))),
    ],
  );
}

Column profilePageOption() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Profile View",
          textAlign: TextAlign.start,
          style: GoogleFonts.sen(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF899AA1))),
    ],
  );
}
