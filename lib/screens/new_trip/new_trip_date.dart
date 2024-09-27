import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:obsser_1/screens/new_trip/new_trip_back.dart';

/* ##### 여행 날짜 선택 화면 ##### */
class NewTDateScreen extends StatefulWidget {
  final String tripTitle; // 여행 제목

  const NewTDateScreen({super.key, required this.tripTitle});

  @override
  State<NewTDateScreen> createState() => _NewTDateScreenState();
}

class _NewTDateScreenState extends State<NewTDateScreen> {
  bool isNextEnabled = false; // '다음' 버튼 활성화 여부
  DateTime? _rangeStart; // 여행 시작 날짜
  DateTime? _rangeEnd; // 여행 종료 날짜
  DateTime _focusedDay = DateTime.now(); // 현재 포커스된 날짜
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // 범위 선택 모드

  // ### '다음' 버튼 활성화 상태를 업데이트하는 함수 ###
  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = _rangeStart != null && _rangeEnd != null; // 시작과 종료 날짜가 모두 선택되었을 때 활성화
    });
  }

  // ### 이전 및 다음 버튼 UI 및 동작 정의 ###
  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // '이전' 버튼 클릭 시 이전 화면으로 이동
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFC5C6CC), // 버튼 색상
            foregroundColor: const Color(0xFFFFFFFF), // 텍스트 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('이전', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          onPressed: isNextEnabled
              ? () {
                  // '다음' 버튼 클릭 시 날짜 형식을 'yyyy.MM.dd'로 변환
                  String formattedStartDate = DateFormat('yyyy.MM.dd').format(_rangeStart!);
                  String formattedEndDate = DateFormat('yyyy.MM.dd').format(_rangeEnd!);

                  // 다음 페이지로 이동하며 선택된 여행 제목과 날짜 범위를 전달
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTBackScreen(
                        tripTitle: widget.tripTitle,
                        rangeStart: formattedStartDate,
                        rangeEnd: formattedEndDate,
                      ),
                    ),
                  );
                }
              : null, // 비활성화 상태에서는 동작하지 않음
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), // 활성화된 버튼 색상
            foregroundColor: const Color(0xFFFFFFFF), // 활성화된 텍스트 색상
            disabledForegroundColor: const Color(0xFFFFFFFF), // 비활성화된 텍스트 색상
            disabledBackgroundColor: const Color(0xFFFFDEA0), // 비활성화된 버튼 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('다음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  // ### 날짜 선택 화면 UI ###
  Widget _buildDatePage() {
    final List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행 기간을 선택해주세요!', // 화면 상단의 안내 텍스트
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA), // 달력 배경색
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2024, 1, 1), // 선택 가능한 최소 날짜
                lastDay: DateTime(2030, 12, 31), // 선택 가능한 최대 날짜
                daysOfWeekHeight: 40,
                rangeStartDay: _rangeStart, // 선택된 시작 날짜
                rangeEndDay: _rangeEnd, // 선택된 종료 날짜
                rangeSelectionMode: _rangeSelectionMode, // 범위 선택 모드
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _rangeStart = start; // 선택된 시작 날짜 업데이트
                    _rangeEnd = end; // 선택된 종료 날짜 업데이트
                    _focusedDay = focusedDay;
                    _updateNextButtonState(); // 날짜 선택 후 '다음' 버튼 상태 업데이트
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay; // 선택된 날짜로 포커스 업데이트
                    if (_rangeSelectionMode == RangeSelectionMode.toggledOn) {
                      if (_rangeStart == null) {
                        _rangeStart = selectedDay; // 시작 날짜 설정
                      } else {
                        _rangeEnd = selectedDay; // 종료 날짜 설정
                      }
                      _updateNextButtonState(); // 날짜 선택 후 '다음' 버튼 상태 업데이트
                    }
                  });
                },
                headerStyle: HeaderStyle(
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.zero,
                  formatButtonVisible: false, // 형식 버튼 비활성화
                  titleTextFormatter: (date, locale) {
                    return "${monthNames[date.month - 1]} ${date.year}"; // 월 이름 형식 지정
                  },
                  headerPadding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  titleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) {
                    return DateFormat.E(locale).format(date).substring(0, 2).toUpperCase(); // 요일 형식 지정
                  },
                  weekdayStyle: const TextStyle(fontSize: 12),
                  weekendStyle: const TextStyle(fontSize: 12),
                ),
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
                  weekendTextStyle: TextStyle(fontSize: 15, color: Color(0xFF494A50), fontWeight: FontWeight.bold),
                  outsideDaysVisible: true,
                  todayDecoration: BoxDecoration(
                    color: Color(0xFF85C59A), // 오늘 날짜의 배경색
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF), // 오늘 날짜의 텍스트 색상
                    fontSize: 15,
                  ),
                  rowDecoration: BoxDecoration(
                    color: Color(0xFFF6F6F6), // 달력 행의 배경색
                  ),
                ),
              ),
            ),
          ),
          if (_rangeStart != null && _rangeEnd != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '선택된 기간: ${DateFormat('yyyy.MM.dd').format(_rangeStart!)} - ${DateFormat('yyyy.MM.dd').format(_rangeEnd!)}', // 선택된 날짜 범위 출력
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          _buildDatePage(), // 날짜 선택 페이지
          const Spacer(),
          _buildPNButton(), // 이전 및 다음 버튼
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
