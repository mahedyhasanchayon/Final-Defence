import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketPageOption extends StatefulWidget {
  const TicketPageOption({super.key});

  @override
  State<TicketPageOption> createState() => _TicketPageOptionState();
}

class _TicketPageOptionState extends State<TicketPageOption> {
  String? _selectedOption;
  String? _selectedtime;
  String _selectedOptionto = 'DIU Smart City';
  Future createBooking(
      {required String from, required to, required time}) async {
    final docBooking =
        FirebaseFirestore.instance.collection('booking').doc(_selectedtime);
    final json = {
      'from': from,
      'to': to,
      'time': time,
    };

    await docBooking.set(json);
  }

  List<String> _dropdownOptionsfrom = [
    'Mirpur & ECB',
    'Dhanmondi',
    'Uttara',
  ];
  List<String> _dropdownOptionsto = [
    'DIU Smart City',
  ];
  List<String> _dropdownTime = ['7.00 am', '8.30 am', '9.30 am', '10.30 am'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIU Transport System",
            style: GoogleFonts.roboto(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                letterSpacing: 1)),
        shadowColor: Color.fromARGB(50, 184, 208, 249),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: SvgPicture.asset("assets/images/menu.svg")),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image(image: AssetImage("assets/images/avatar_image.png")))
        ],
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
                          hint: Text("Select Your Departure Location"),
                          value: _selectedOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOption = newValue;
                            });
                          },
                          items: _dropdownOptionsfrom.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
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
                          value: "DIU Smart City",
                          onChanged: (String? newValue) {},
                          items: _dropdownOptionsto.map((String option) {
                            return DropdownMenuItem<String>(
                              value: "DIU Smart City",
                              child: Text("DIU Smart City"),
                            );
                          }).toList(),
                          decoration: InputDecoration(
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
                          hint: Text("Select Your Time"),
                          value: _selectedtime,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedtime = newValue;
                            });
                          },
                          items: _dropdownTime.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
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
                              onPressed: () {
                                final from = _selectedOption;
                                final to = _selectedOptionto;
                                final time = _selectedtime;
                                createBooking(from: from!, to: to, time: time);
                              },
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
