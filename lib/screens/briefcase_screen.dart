import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/myfavorite.dart';
import 'package:obsser_1/screens/new_trip/new_trip_screen.dart';
import 'package:obsser_1/screens/new_trip/trip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* ##### 여행 히스토리 및 일정 관리 페이지 ##### */
class BriefcaseScreen extends StatefulWidget {
  const BriefcaseScreen({super.key});

  @override
  State<BriefcaseScreen> createState() => _BriefcaseScreenState();
}

class _BriefcaseScreenState extends State<BriefcaseScreen> {
  // 달력에 표시할 월 이름 리스트
  final List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  List<Map<String, String>> travelCards = []; // 서버에서 받아온 여행 카드 데이터 저장
  bool isLoading = true; // 로딩 상태 표시 변수

  /* ### 서버에서 여행 데이터를 받아오는 함수 ### */
  Future<List<Map<String, String>>> fetchTravelData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(Uri.parse('http://3.37.197.251:5000/mytrip'),headers: {'Authorization': 'Bearer $token'},); // 서버 요청
    // final response = await http.get(Uri.parse('http://127.0.0.1:5000/mytrip'));

    if (response.statusCode == 200) {
      // 응답 성공시, 데이터를 파싱하고 Map<String, String>으로 변환
      List<dynamic> data = json.decode(response.body)['data'];
      List<Map<String, String>> travelData = data.map((item) {

        String dadate = formatTimestamp(item['date'].toString());

        return {
          'name': item['name'].toString(),
          'date': dadate,
          'image_url': item['image_url'].toString(),
        };
      }).toList();


      return travelData;
    } else {
      throw Exception('Failed to load travel data');
    }
  }

  String formatTimestamp(String timestamp) {
    // 시작 날짜와 끝 날짜를 각각 슬라이싱 (첫 8자리와 마지막 8자리)
    String startDate = timestamp.substring(0, 8); // '20241001'
    String endDate = timestamp.substring(8); // '20241008'

    // 슬라이싱된 문자열을 yyyy.mm.dd 형식으로 변환
    String formattedStartDate = '${startDate.substring(0, 4)}.${startDate.substring(4, 6)}.${startDate.substring(6, 8)}';
    String formattedEndDate = '${endDate.substring(0, 4)}.${endDate.substring(4, 6)}.${endDate.substring(6, 8)}';

    // 'yyyy.mm.dd - yyyy.mm.dd' 형식으로 출력
    return '$formattedStartDate - $formattedEndDate';
  }


  /* ### 페이지 로드 시 서버에서 데이터 가져오기 ### */
  @override
  void initState() {
    super.initState();
    fetchTravelData().then((data) {
      if (mounted) {
        setState(() {
          travelCards = data; // 서버에서 받은 데이터 저장
          isLoading = false;  // 로딩 완료
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false; // 오류 발생 시에도 로딩 완료 상태로 설정
      });
    });
  }

  /* ### 메인 화면 구성 ### */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0,  // AppBar 높이를 없애기 위해 0으로 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 전체 배경 흰색
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
            child: Column(
              children: [
                _buildCalendar(), // 달력 위젯
                const SizedBox(height: 30),
                _buildFavoriteSection(), // 나의 관심장소 섹션
                const SizedBox(height: 30),
                _buildTravelHistoryTitle(), // 여행 히스토리 제목
                Expanded(
                  child: isLoading 
                    ? const Center(child: CircularProgressIndicator()) // 로딩 중
                    : _buildTravelHistoryList(), // 여행 히스토리 리스트
                ),
              ],
            ),
          ),
          _buildAddScheduleButton(), // 새로운 일정 추가 버튼
        ],
      ),
    );
  }

  /* ### 달력 위젯 ### */
  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA), // 배경색 설정
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3),
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(2024, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          daysOfWeekHeight: 40,
          headerStyle: HeaderStyle(
            leftChevronPadding: EdgeInsets.zero,
            rightChevronPadding: EdgeInsets.zero,
            formatButtonVisible: false,  // 형식 버튼 숨기기
            titleTextFormatter: (date, locale) {
              return "${_monthNames[date.month - 1]} ${date.year}"; // 월과 년도 표시
            },
            headerPadding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
            titleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              return DateFormat.E(locale).format(date).substring(0, 2).toUpperCase(); // 요일 포맷팅
            },
            weekdayStyle: const TextStyle(fontSize: 12),
            weekendStyle: const TextStyle(fontSize: 12),
          ),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(
              fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
            weekendTextStyle: TextStyle(
              fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
            outsideDaysVisible: true,
            todayDecoration: BoxDecoration(
              color: Color(0xFF85C59A), // 오늘 날짜 색상
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF), fontSize: 15),
            rowDecoration: BoxDecoration(
              color: Color(0xFFF6F6F6), // 행 배경색 설정
            ),
          ),
        ),
      ),
    );
  }

  /* ### 나의 관심장소 섹션 ### */
  Widget _buildFavoriteSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const FavoriteScreen()),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(' 나의 관심', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  /* ### 여행 히스토리 제목 ### */
  Widget _buildTravelHistoryTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        ' 여행 히스토리',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }

  /* ### 여행 히스토리 리스트 ### */
  Widget _buildTravelHistoryList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...travelCards.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> card = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => TripScreen(index: index)),
                  );
                },
                child: _buildTravelCard(
                  title: card['name']!,
                  date: card['date']!,
                  image_url: card['image_url']!,
                ),
              ),
            );
          }),
          const SizedBox(height: 50), // 맨 아래 여백 추가
        ],
      ),
    );
  }


  /* ### 여행 카드 위젯 ### */
  Widget _buildTravelCard({required String title, required String date, required String image_url}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
      ),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(image_url, fit: BoxFit.cover, width: double.infinity, height: 100), // 카드 이미지
            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text(date, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ### 새로운 일정 추가 버튼 ### */
  Widget _buildAddScheduleButton() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const NewTScreen()), // 새로운 일정 추가 페이지로 이동
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), // 버튼 배경색
            foregroundColor: const Color(0xFFFFFFFF), // 버튼 텍스트 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 50), // 버튼 크기 설정
            elevation: 0,
          ),
          child: const Text(
            '새로운 일정 추가', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
