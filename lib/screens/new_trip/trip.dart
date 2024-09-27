import 'package:flutter/material.dart';
import 'package:obsser_1/screens/new_trip/new_trip_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* ##### 여행 카드 상세보기 화면 ##### */
class TripScreen extends StatefulWidget {
  final int index;  // 선택된 카드의 인덱스
  const TripScreen({super.key, required this.index});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<Map<String, String>> travelCards = []; // 서버에서 받아온 여행 카드 데이터를 저장
  bool isLoading = true; // 로딩 상태 변수

  // ### 서버에서 여행 데이터를 받아오는 함수 ###
  Future<List<Map<String, String>>> fetchTravelData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/travel_data')); // 서버에서 여행 데이터 요청

    if (response.statusCode == 200) {
      // 서버 응답이 성공적일 때
      List<dynamic> data = json.decode(response.body); // JSON 응답 파싱

      // 응답 데이터를 List<Map<String, String>> 형식으로 변환
      List<Map<String, String>> travelData = data.map((item) {
        return {
          'title': item['title'].toString(), // 명시적으로 String 변환
          'date': item['date'].toString(),
          'imageUrl': item['imageUrl'].toString(),
        };
      }).toList();

      return travelData; // 변환된 데이터 반환
    } else {
      throw Exception('Failed to load travel data'); // 오류 처리
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTravelData().then((data) {
      // 서버에서 데이터를 받은 후 상태 업데이트
      if (mounted) {
        setState(() {
          travelCards = data; // 서버에서 받은 데이터를 저장
          isLoading = false; // 로딩 완료 상태로 변경
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false; // 오류 발생 시 로딩 완료 상태로 변경
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // AppBar 높이 제거
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator()) // 로딩 중일 때 로딩 아이콘 표시
                      : _buildSelectedTravelCard(), // 선택한 여행 카드만 보여줌
                ),
              ],
            ),
          ),
          _buildAddScheduleButton(), // 새로운 일정 추가 버튼
        ],
      ),
    );
  }

  // ### 선택한 여행 카드만 보여주는 위젯 ###
  Widget _buildSelectedTravelCard() {
    // 선택된 인덱스가 여행 카드 리스트를 넘어가면 오류 메시지 표시
    if (widget.index >= travelCards.length) {
      return const Center(child: Text('해당하는 여행 카드가 없습니다.'));
    }

    // 선택된 카드 정보 가져오기
    Map<String, String> selectedCard = travelCards[widget.index];

    return _buildTravelCard(
      title: selectedCard['title']!,
      date: selectedCard['date']!,
      imageUrl: selectedCard['imageUrl']!,
    );
  }

  // ### 여행 카드 UI 위젯 ###
  Widget _buildTravelCard({required String title, required String date, required String imageUrl}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 카드 모서리 둥글게
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // 이미지 모서리 둥글게
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 100), // 이미지
            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white), // 제목 텍스트 스타일
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.white), // 날짜 텍스트 스타일
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ### 새로운 일정 추가 버튼 UI ###
  Widget _buildAddScheduleButton() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // 새로운 일정 추가 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewTScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), // 버튼 색상
            foregroundColor: const Color(0xFFFFFFFF), // 버튼 텍스트 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 50), // 버튼 크기 설정
            elevation: 0,
          ),
          child: const Text(
            '새로운 일정 추가', // 버튼 텍스트
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
