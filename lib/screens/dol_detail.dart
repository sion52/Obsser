import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';

class DolDetail extends StatelessWidget {
  final int imageIndex;
  
  final List<String> images = [
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  DolDetail({required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(images[imageIndex], height: 550, fit: BoxFit.cover,),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }, 
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            Text('상세페이지 $imageIndex', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
