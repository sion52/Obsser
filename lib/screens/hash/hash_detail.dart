import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:obsser_1/screens/hash/hash_detail_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* ##### 키워드별 여행지 화면 ##### */
class HashDetail extends StatefulWidget {
  final Function(int) onKeywordSelected; // 선택된 키워드에 대한 콜백
  final String selectedKeyword; // 선택된 키워드

  const HashDetail({super.key, required this.selectedKeyword, required this.onKeywordSelected});

  @override
  State<HashDetail> createState() => _HashDetailState();
}

class _HashDetailState extends State<HashDetail> {
  List<bool> isFavoriteList = []; // 각 카드의 즐겨찾기 상태 리스트
  bool isLoading = true; // 로딩 상태 표시
  late Future<List<Map<String, String>>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = fetchPlacesData(widget.selectedKeyword); // 페이지 로드 시 서버에서 데이터 가져오기
  }

  // 서버에서 여행지 데이터 가져오는 함수
  Future<List<Map<String, String>>> fetchPlacesData(String keyword) async {
    try {
      final response = await http.get(Uri.parse('http://3.37.197.251:5000/place_pages/$keyword'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];

        // 데이터 크기만큼 isFavoriteList를 초기화합니다.
        isFavoriteList = List<bool>.filled(data.length, false);

        return data.map((item) {
          return {
            'name': item['name'].toString(),
            'image': item['image'].toString(),
          };
        }).toList();
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // 즐겨찾기 상태를 서버에 POST 요청으로 보내는 함수
  Future<void> sendFavoriteStatusToServer(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    
    try {
      // POST 요청 보낼 데이터
      List<String> data = [name];
      
      // 서버로 POST 요청 전송
      final response = await http.post(
        Uri.parse('http://3.37.197.251:5000/mytrip/add'),
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
        body: jsonEncode(<String, List>{
          'add_table': data,
        }),
      );

      if (response.statusCode == 200) {
        print("즐겨찾기 상태가 서버에 전송되었습니다.");
      } else {
        print("즐겨찾기 전송 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("서버로 데이터 전송 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 16), // 패딩 설정
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
              children: [
                buildKeywordHeader(), // 키워드별 여행지 제목
                const SizedBox(height: 8),
                FutureBuilder<List<Map<String, String>>>(
                  future: _placesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      final places = snapshot.data!;
                      return buildKeywordChips(places);
                    }
                  },
                ), // 키워드 칩 및 카드 리스트
              ],
            ),
          ),
          /* ### 여행 루트 문구 및 버튼 ### */
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: [
                const Text(
                  '옵써가 계획한 ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF000000)),
                ),
                Text(
                  widget.selectedKeyword, // 선택한 키워드 표시
                  style: const TextStyle(fontSize: 16, color: Color(0xFF497F5B)),
                ),
                const Text(
                  ' 여행루트는 어때요? ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF000000)),
                ),
                GestureDetector(
                  onTap: () {
                    // 여행루트 상세 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HashDetailRoute(selectedKeyword: widget.selectedKeyword)),
                    );
                  },
                  child: const Text(
                    '보러가기>',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF497F5B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ### 키워드별 여행지 제목 ### */
  Widget buildKeywordHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /* ### 키워드 칩 및 여행지 카드 리스트 ### */
  Widget buildKeywordChips(List<Map<String, String>> places) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0), // 가로 패딩 0
      child: Container(
        height: 660, // 전체 컨테이너 높이
        width: double.infinity, // 가로는 화면 전체 크기
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // 배경색 흰색
          borderRadius: BorderRadius.circular(20), // 둥근 모서리
          border: Border.all(width: 1, color: const Color(0xA6A4A4A4)), // 테두리
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 0), // 내부 패딩 설정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
                children: [
                  const SizedBox(height: 10),
                  /* ### 여행지 카드 리스트 ### */
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: places.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, String> place = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: _buildCard(index, place['name']!, place['image']!),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* ### 하단 아이콘 ### */
            Align(
              alignment: Alignment.bottomCenter, // 가로 중앙, 세로 하단 정렬
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0), // 하단 패딩
                child: SvgPicture.asset('assets/icons/Down.svg'), // 아래 화살표 아이콘
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ### 여행지 카드 생성 함수 ### */
  Widget _buildCard(int index, String title, String base64Image) {
    // Base64 문자열을 디코딩하여 이미지로 변환
    final decodedBytes = base64Decode(base64Image);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 카드 모서리 둥글게
      ),
      elevation: 0, // 그림자 없음
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // 카드 내부 이미지 모서리 둥글게
        child: Stack(
          children: [
            /* ### 여행지 이미지 ### */
            Image.memory(decodedBytes, fit: BoxFit.cover, width: double.infinity, height: 220), // Base64 디코딩된 이미지
            /* ### 여행지 이름 ### */
            Positioned(
              bottom: 10,
              left: 15,
              child: Text(
                title,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            /* ### 즐겨찾기 버튼 ### */
            Positioned(
              bottom: 15,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  // 즐겨찾기 상태 토글
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index];
                    // 즐겨찾기 상태를 서버로 전송
                    sendFavoriteStatusToServer(title);
                  });
                },
                child: SvgPicture.asset(
                  isFavoriteList[index] ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                  colorFilter: ColorFilter.mode(
                    isFavoriteList[index] ? const Color(0xFFFF5555) : const Color(0xFFFFFFFF), // 즐겨찾기 상태에 따른 색상
                    BlendMode.srcIn,
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
