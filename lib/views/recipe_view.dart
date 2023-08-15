import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  late String finalUrl ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
               Expanded(
                 flex: 1,
                 child: Container(
              padding: EdgeInsets.only(top: Platform.isIOS? 60: 30, right: 24,left: 24,bottom: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          HexColor("#3c2155"),
                          HexColor("#cf5581")
                        ],
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft)),
              child:  Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "AppGuy",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Overpass'),
                    ),
                    Text(
                      "Recipes",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontFamily: 'Overpass'),
                    )
                  ],
              ),
            ),
               ),
             Container(
              height: MediaQuery.of(context).size.height - (Platform.isIOS ? 104 : 30),
              width: MediaQuery.of(context).size.width,
              child:  InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(finalUrl)),
                onLoadStop: (_controller, url) {
                  print("Page finished loading: $url");
                },
              )
            ),
          ],
        ),
      )
    );
  }
}
