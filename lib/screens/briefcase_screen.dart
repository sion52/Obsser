import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BriefcaseScreen extends StatefulWidget {
  const BriefcaseScreen({Key? key}) : super(key: key);

  @override
  _BriefcaseScreenState createState() => _BriefcaseScreenState();
}

class _BriefcaseScreenState extends State<BriefcaseScreen> {
  // 월 이름 리스트
  final List<String> _monthNames = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 달력 컨테이너
                  _buildCalendar(),
                  SizedBox(height: 30),
                  // 여행 히스토리 제목
                  _buildTravelHistoryTitle(),
                  // 여행 카드
                  _buildTravelCard(
                    title: '8월 힐링 제주도',
                    date: '2024.08.15 - 2024.08.18',
                    imageUrl: 'assets/histories/photo.png' // 실제 이미지 URL
                  ),
                  SizedBox(height: 50),
                  // 추가적인 여행 카드도 여기에 추가할 수 있습니다.
                ],
              ),
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
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(2024, 1, 1),
          lastDay: DateTime(2024, 12, 31),
          locale: 'ko-KR',
          daysOfWeekHeight: 40,
          headerStyle: HeaderStyle(
            leftChevronPadding: EdgeInsets.zero,
            rightChevronPadding: EdgeInsets.zero,
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) {
              return "${_monthNames[date.month - 1]} ${date.year}";
            },
            headerPadding: EdgeInsets.fromLTRB(0, 25, 0, 10),
            titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          calendarStyle: CalendarStyle(
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        ' 여행 히스토리',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 90),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(date, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white)),
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
            // 일정 추가 로직
          },
          child: Text(
            '새로운 일정 추가',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 5),
            backgroundColor: Color(0xFFFFDEA0),
            foregroundColor: Color(0xFF000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(170, 40),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
