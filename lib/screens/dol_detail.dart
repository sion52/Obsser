import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class DolDetail extends StatefulWidget {
  final int imageIndex;

  final List<String> images = [
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  DolDetail({super.key, required this.imageIndex});

  @override
  // ignore: library_private_types_in_public_api
  _DolDetailState createState() => _DolDetailState();
}
class _DolDetailState extends State<DolDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
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
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    }, 
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0), // 오른쪽 패딩 추가
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 상품 페이지로 이동하는 코드
                        },
                        child: const Text(
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
                          Share.share('Test', subject: 'Cool');
                        },
                        child: SvgPicture.asset('assets/icons/Share.svg'),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '제주마음샌드 케이크',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  const Align(
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
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '정가 33,000원',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Row(
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
            // Text('상세페이지 ${widget.imageIndex}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE8F1EA),
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
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  isFavorite ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF000000),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () => {
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/Briefcase.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF000000),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            GestureDetector(
              onTap: () => {
                setState(() {
                  
                })
              },
              child: Container(
                width: 210,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const Center(
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
