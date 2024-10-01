import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

/* ##### 상세 페이지 화면 ##### */
class DolDetail extends StatefulWidget {
  final int imageIndex; // 선택된 이미지 인덱스

  // 이미지, 제목, 설명 리스트
  final List<String> images = [
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];
  final List<String> title = [
    '제주마음샌드 케이크',
    '베케의 돌담: 정원 도슨트',
    '올레식당 예약',
    '렌트카 예약',
  ];
  final List<String> explanation = [
    '오직 제주도 파리바게뜨에서만 만날 수 있는 케이크',
    '베케의 돌담 감상하기, 정원 도슨트를 예약하세요',
    '올레식당 웨이팅 없이 이용하기',
    '렌트카 22% 할인 받기',
  ];

  DolDetail({super.key, required this.imageIndex});

  @override
  State<DolDetail> createState() => _DolDetailState();
}

class _DolDetailState extends State<DolDetail> {
  bool isFavorite = false; // 즐겨찾기 상태
  String price = ''; // 서버에서 받아올 price
  String description = ''; // 서버에서 받아올 description
  String image = ''; // 서버에서 받아올 image URL

  @override
  void initState() {
    super.initState();
    fetchData(); // 페이지 로드 시 서버에서 데이터 가져오기
  }

  // 서버에서 price, description, image 데이터를 가져오는 함수
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/detail/${widget.imageIndex}')); // 서버 요청 URL에 이미지 인덱스를 포함
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          price = data['price'].toString(); // price 데이터 가져오기
          description = data['description']; // description 데이터 가져오기
          image = data['image']; // image URL 데이터 가져오기
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // 찜 상태를 서버에 저장하는 함수
  Future<void> postFavoriteStatus(bool isFavorite) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/detail/${widget.imageIndex}/like'), // 서버의 찜 상태 저장 API URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'item_id': widget.imageIndex, // 찜한 항목의 인덱스
          'is_favorite': isFavorite, // 찜 상태 (true/false)
        }),
      );

      if (response.statusCode == 200) {
        print('찜 상태가 성공적으로 저장되었습니다.');
      } else {
        print('찜 상태 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜 상태 저장 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
        toolbarHeight: 0, // 툴바 높이 0
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* ### 이미지 및 뒤로가기 버튼 ### */
            Stack(
              children: [
                // 서버에서 가져온 이미지 표시
                image.isNotEmpty
                    ? Image.network(image, height: 470, fit: BoxFit.cover)
                    : Image.asset(widget.images[widget.imageIndex], height: 470, fit: BoxFit.cover),
                // 뒤로가기 버튼
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
                      color: Color(0xFF121212),
                    ),
                  ),
                ),
              ],
            ),
            /* ### 상품 상세 정보 ### */
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0), // 패딩 설정
              child: Column(
                children: [
                  // 상품 링크 및 공유 아이콘
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: SvgPicture.asset('assets/icons/Share.svg'), // 공유 아이콘
                      ),
                    ],
                  ),
                  // 상품 제목
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title[widget.imageIndex],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  // 서버에서 가져온 상품 설명
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description.isNotEmpty ? description : widget.explanation[widget.imageIndex],
                      style: const TextStyle(
                        color: Color(0xFF4D5049),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 서버에서 가져온 정가 텍스트
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '정가 $price원',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // 할인율과 가격 표시 (데이터 추가 시 여기서 수정 가능)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 3, 5),
                        child: Text(
                          '5%',
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
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
                        child: Text(
                          '원',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/banners/detail.png'),
                ],
              ),
            ),
          ],
        ),
      ),
      /* ### 하단 네비게이션 바 ### */
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE8F1EA), // 배경색
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 즐겨찾기 버튼
            GestureDetector(
              onTap: () async {
                setState(() {
                  isFavorite = !isFavorite; // 즐겨찾기 상태 변경
                });
                await postFavoriteStatus(isFavorite); // 서버에 찜 상태 전송
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
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
            // 브리프케이스 아이콘 버튼
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(initialIndex: 2), // '나의 일정' 탭으로 이동
                  ),
                  (route) => false, // 뒤로가기 버튼을 비활성화하여 이전 페이지로 돌아가지 않음
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
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
            // 예약하기 버튼
            GestureDetector(
              onTap: () {
                // 예약하기 버튼 동작
              },
              child: Container(
                width: 210,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
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
