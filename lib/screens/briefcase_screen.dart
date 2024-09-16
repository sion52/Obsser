import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:obsser_1/screens/new_trip_screen.dart';

class BriefcaseScreen extends StatefulWidget {
  const BriefcaseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BriefcaseScreenState createState() => _BriefcaseScreenState();
}
class _BriefcaseScreenState extends State<BriefcaseScreen> {
  // 월 이름 리스트
  final List<String> _monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
            child: Column(
              children: [
                // 달력 컨테이너
                _buildCalendar(),
                const SizedBox(height: 30),
                // 여행 히스토리 제목
                _buildTravelHistoryTitle(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 여행 카드
                        _buildTravelCard(
                          title: '8월 힐링 제주도',
                          date: '2024.08.15 - 2024.08.18',
                          imageUrl: 'assets/histories/photo.png' // 실제 이미지 URL
                        ),
                        const SizedBox(height: 5),
                        // 추가적인 여행 카드도 여기에 추가할 수 있습니다.
                        _buildTravelCard(
                          title: '8월 힐링 제주도',
                          date: '2024.08.15 - 2024.08.18',
                          imageUrl: 'assets/histories/photo.png' // 실제 이미지 URL
                        ),
                        const SizedBox(height: 5),
                        _buildTravelCard(
                          title: '8월 힐링 제주도',
                          date: '2024.08.15 - 2024.08.18',
                          imageUrl: 'assets/histories/photo.png' // 실제 이미지 URL
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 새로운 일정 추가 버튼
          _buildAddScheduleButton(),
        ],
      ),
    );
  }

  // 달력 위젯 생성
  Widget _buildCalendar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
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
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) {
              return "${_monthNames[date.month - 1]} ${date.year}";
            },
            headerPadding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
            titleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              return DateFormat.E(locale).format(date).substring(0, 2).toUpperCase(); 
            },
            weekdayStyle: const TextStyle(fontSize: 12),
            weekendStyle: const TextStyle(fontSize: 12),
          ),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
            weekendTextStyle: TextStyle(fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
            outsideDaysVisible: true,
            todayDecoration: BoxDecoration(
              color: Color(0xFF85C59A),
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
              fontSize: 15,
            ),
            rowDecoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
            ),
          ),
        ),
      ),
    );
  }

  // 여행 히스토리 제목 위젯 생성
  Widget _buildTravelHistoryTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        ' 여행 히스토리',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }

  // 여행 카드 위젯 생성
  Widget _buildTravelCard({required String title, required String date, required String imageUrl}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 100),
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

  // 새로운 일정 추가 버튼 위젯 생성
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
              MaterialPageRoute(builder: (context) => const NewTScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            minimumSize: const Size(170, 50),
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
