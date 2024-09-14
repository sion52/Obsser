import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DolDetail extends StatefulWidget {
  final int imageIndex;

  final List<String> images = [
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  DolDetail({required this.imageIndex});

  @override
  _DolDetailState createState() => _DolDetailState();
}

class _DolDetailState extends State<DolDetail> {
  bool isFavorite = false;

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
                Image.asset(widget.images[widget.imageIndex], height: 470, fit: BoxFit.cover,),
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
                        child: SvgPicture.asset('assets/icons/Share.svg'),
                        // child: Icon(
                        //   Icons.share_outlined,
                        //   color: Color(0xFF717A75),
                        //   size: 25, // 아이콘 크기를 줄임
                        // ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '제주마음샌드 케이크',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '오직 제주도 파리바게뜨에서만 만날 수 있는 케이크',
                      style: TextStyle(
                        color: Color(0xFF4D5049),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '정가 33,000원',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 3, 5),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '5%',
                            style: TextStyle(
                              color: Color(0xFFFF0000),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ), 
                      ),
                      Text(
                        '31,350',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '원',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ), 
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('상세페이지 ${widget.imageIndex}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFE8F1EA),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => {
                setState(() {
                  isFavorite = !isFavorite;
                })
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  isFavorite ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                  color: Color(0xFF000000),
                ),
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              onTap: () => {
                setState(() {
                  
                })
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/briefcase.svg',
                  color: Color(0xFF000000),
                ),
              ),
            ),
            SizedBox(width: 30),
            GestureDetector(
              onTap: () => {
                setState(() {
                  
                })
              },
              child: Container(
                width: 210,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    '예약하기',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
