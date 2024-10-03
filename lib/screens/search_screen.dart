import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://m.map.naver.com/search2/search.naver?query=${widget.query}&sm=hty&style=v5',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      )
    );
  }
}