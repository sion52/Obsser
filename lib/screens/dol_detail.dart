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
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(images[imageIndex], height: 470, fit: BoxFit.cover,),
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
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 0), // 오른쪽 패딩 추가
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 상품 페이지로 이동하는 코드
                        },
                        child: Text(
                          '상품>',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF717A75),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // 공유 기능 구현
                        },
                        child: Icon(
                          Icons.share_outlined,
                          color: Color(0xFF717A75),
                          size: 25, // 아이콘 크기를 줄임
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '제주마음샌드 케이크',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('상세페이지 $imageIndex', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
