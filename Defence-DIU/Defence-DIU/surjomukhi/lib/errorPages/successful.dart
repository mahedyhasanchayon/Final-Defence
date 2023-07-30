import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surjomukhi/errorPages/error.dart';
class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            SizedBox(height: 170.0,),
            SvgPicture.asset("assets/images/successful.svg",height:158.0 ,width:158.0 ),
            SizedBox(height:64.0),
            Text("Successfull",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 18.0,fontWeight: FontWeight.w600,color: Color(0xFF000000))),
            SizedBox(height:18.0),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30.0),
              child: Text("Thanks For booking Tickets Hope You will go timely in bus-stop",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.w400,color: Color(0xFF66A1AA))),
            ),
            SizedBox(height: 50.0,),
            GestureDetector(
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ErrorPage())),),
              child: Container(
                height:55.0 ,
                width: 225.0,
                decoration: BoxDecoration(
                  color: Color(0xFF98EAF3),
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Align(alignment: Alignment.center, child: Text("OK",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 16.0,fontWeight: FontWeight.w500,color: Color(0xFF004A54)))),
              ),
            )
          ],
        )
      ),
    ); 
  }
}