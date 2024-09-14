import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class NewTScreen extends StatefulWidget {
  const NewTScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewTScreenState createState() => _NewTScreenState();
}
class _NewTScreenState extends State<NewTScreen> {
  int pageIndex = 0;
  bool isNextEnabled = false; // 다음 버튼 활성화 여부
  final TextEditingController _controller = TextEditingController();

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  
  @override
  void initState() {
    super.initState();
    // TextField 값 변경 시 호출
    _controller.addListener(() {
      setState(() {
        isNextEnabled = _controller.text.isNotEmpty; // 입력값이 비어있지 않으면 다음 버튼 활성화
      });
    });
  }

  Widget _buildPNButton(int pageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(pageIndex > 0) 
          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 5),
              backgroundColor: const Color(0xFFC5C6CC),
              foregroundColor: const Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              minimumSize: const Size(170, 60),
              elevation: 0,
            ),
            child: const Text('이전', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          ),
        if(pageIndex < 1)
          const SizedBox(width: 170,), // 이전 버튼이 없을 때 여백 맞춤
        const SizedBox(width: 25,),
        ElevatedButton(
          onPressed: isNextEnabled
            ? () {
              // 다음 버튼 눌렀을 때 동작
            }
            : null, 
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), 
            foregroundColor: const Color(0xFFFFFFFF),
            disabledForegroundColor: const Color(0xFFFFFFFF), 
            disabledBackgroundColor: const Color(0xFFFFDEA0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('다음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        ),  
      ],
    );
  }

  Widget _buildTitlePage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 150, 40, 0),
      child: Column(
        children: [
          Center(
            child: Text(
              '여행 제목을 입력하세요!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: const Color(0xFFC5C6CC),
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '힐링하러 떠나는 제주도',
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFFC5C6CC)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePage() {
    final List<String> _monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'  ];

    return Padding(
      padding: EdgeInsets.fromLTRB(40, 150, 40, 0),
      child: Column(
        children: [
          Center(
            child: Text(
              '여행 기간을 선택해주세요!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2030, 12, 31),
                daysOfWeekHeight: 40,
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rangeSelectionMode: _rangeSelectionMode,
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _rangeStart = start;
                    _rangeEnd = end;
                    _focusedDay = focusedDay;
                  });
                },
                onDaySelected:(selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    if (_rangeSelectionMode == RangeSelectionMode.toggledOn) {
                      if (_rangeStart == null) {
                        _rangeStart = selectedDay;
                      } else {
                        _rangeEnd = selectedDay;
                      }
                    }
                  });
                },
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
          ),
          if (_rangeStart != null && _rangeEnd != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '선택된 기간: ${DateFormat('yyyy.MM.dd').format(_rangeStart!)} - ${DateFormat('yyyy.MM.dd').format(_rangeEnd!)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          // _buildTitlePage(),
          // Spacer(),
          // _buildPNButton(0),
          // SizedBox(height: 60,),
          _buildDatePage(),
          Spacer(),
          _buildPNButton(1),
          SizedBox(height: 60,),
        ],
      ),
    );
  }
}