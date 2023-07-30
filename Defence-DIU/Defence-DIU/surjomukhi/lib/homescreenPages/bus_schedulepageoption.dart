import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:surjomukhi/views/landing/landing.dart';

class BusScheduleOption extends StatefulWidget {
  const BusScheduleOption({Key? key}) : super(key: key);

  @override
  State<BusScheduleOption> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<BusScheduleOption> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();

        if (isLastPage) {
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LandingPage())),
              ),
              title: Text(
                "Bus Time",
                style: TextStyle(color: Colors.black),
              )),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://docs.google.com/spreadsheets/d/1nFRgMpTl5ypO04fSna5aqWFXQCenmkai6vNDLDOfjUA/edit?usp=sharing")),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1
                  ? Container(
                      child: LinearProgressIndicator(
                        value: _progress,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
