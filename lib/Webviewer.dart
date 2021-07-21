import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  final String webUrl;
  final Completer<WebViewController> cntrl = Completer<WebViewController>();
  NewsView({required this.webUrl});
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News',style: TextStyle(color: Colors.blue),),
            Text('App'),
          ],
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.webUrl,
          onWebViewCreated: ((WebViewController webcntrl){
            widget.cntrl.complete(webcntrl);
          }),
        ),
      ),
    );
  }
}
