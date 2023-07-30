import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surjomukhi/errorPages/successful.dart';


Future<List> result(id,semester) async {

  var response = await http.get(Uri.parse(
      'http://software.diu.edu.bd:8189/result?grecaptcha=&semesterId=$id&studentId=$semester'));
  if (response.statusCode == 200) {
    var resultData = jsonDecode(response.body);
    
    List resultlist = resultData[{}];
    return resultlist;
  } else {
    throw Exception("Error!");
  }
}


class DataGet extends StatefulWidget {
  String id;
  String semester;

  DataGet(
      {Key? key,
      required String this.id,
      required String this.semester})
      ;

  @override
  State<DataGet> createState() => _DataGetState();
}

class _DataGetState extends State<DataGet> {
  late Future<List> movieListfuture;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieListfuture = result(widget.id,widget.semester);
    print("${movieListfuture.toString()}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: movieListfuture,
          builder: (BuildContext context, AsyncSnapshot<List> sn) {
            if (sn.hasData) {
              List? moviedata = sn.data;
              return Text("$moviedata");
            } else if (sn.hasError) {
              return SuccessfulPage();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}