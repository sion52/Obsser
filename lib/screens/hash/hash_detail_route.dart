import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* ##### 해시태그 여행 루트 상세 페이지 ##### */
class HashDetailRoute extends StatefulWidget {
  final String selectedKeyword; // 선택한 키워드

  const HashDetailRoute({super.key, required this.selectedKeyword});

  @override
  State<HashDetailRoute> createState() => _HashDetailRouteState();
}

class _HashDetailRouteState extends State<HashDetailRoute> {
  late Future<List<Map<String, String>>> _placesFuture; // Future로 서버에서 데이터를 받아옴

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* ### 뒤로가기 버튼 및 키워드 헤더 ### */
                  Stack(
                    children: [
                      Positioned(
                        top: 5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, widget.selectedKeyword); // 뒤로가기
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Color(0xFF000000), // 아이콘 색상
                          ),
                        ),
                      ),
                      Center(child: buildKeywordHeader()), // 키워드 헤더
                    ],
                  ),
                  const SizedBox(height: 35),
                  /* ### FutureBuilder로 서버 데이터를 처리 ### */
                  FutureBuilder<List<Map<String, String>>>(
                    future: _placesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('오류 발생: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('데이터가 없습니다.'));
                      }

                      List<Map<String, String>> places = snapshot.data!;
                      return Column(
                        children: places.map((place) {
                          return Column(
                            children: [
                              buildCard(place['name']!, place['image']!),
                              const SizedBox(height: 20), // 간격 추가
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ### 키워드 헤더 위젯 ### */
  Widget buildKeywordHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 패딩 설정
      decoration: BoxDecoration(
        color: const Color(0xFF497F5B), // 배경색
        borderRadius: BorderRadius.circular(25), // 둥근 모서리
      ),
      child: Text(
        '옵써가 계획한 ${widget.selectedKeyword} 여행루트예요.', // 선택한 키워드 표시
        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16), // 텍스트 스타일
      ),
    );
  }

  /* ### 여행지 카드 위젯 ### */
  Widget buildCard(String title, String base64Image) {
    // Base64 문자열을 디코딩하여 이미지로 변환
    final decodedBytes = base64Decode(base64Image);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 여행지 이름
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800), // 제목 스타일
        ),
        const SizedBox(height: 10),
        // 여행지 이미지
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // 이미지 모서리 둥글게
            child: Image.memory(
              decodedBytes, // Base64 디코딩된 이미지
              width: 250, // 이미지 가로 크기
              height: 190, // 이미지 세로 크기
              fit: BoxFit.cover, // 이미지 크기 맞춤
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }


  /* ### 소요시간 표시 위젯 ### */
  Widget buildtime(int time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20), // 세로 패딩
      child: Stack(
        children: [
          const Positioned(
            left: 15, 
            child: Icon(Icons.more_vert, color: Color(0xFF000000)), // 세로 점 아이콘
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '소요시간 $time분', 
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700), // 소요시간 텍스트
              ),
            ],
          ),
        ],
      ),
    );
  }
}
