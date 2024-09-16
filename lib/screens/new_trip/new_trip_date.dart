import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:obsser_1/screens/new_trip/new_trip_back.dart';

class NewTDateScreen extends StatefulWidget {
  final String tripTitle;
  const NewTDateScreen({super.key, required this.tripTitle});

  @override
  // ignore: library_private_types_in_public_api
  _NewTDateScreenState createState() => _NewTDateScreenState();
}

class _NewTDateScreenState extends State<NewTDateScreen> {
  bool isNextEnabled = false; // 다음 버튼 활성화 여부
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  
  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = _rangeStart != null && _rangeEnd != null;
    });
  }

  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
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
        const SizedBox(width: 25,),
        ElevatedButton(
          onPressed: isNextEnabled
            ? () {
              // 다음 버튼 눌렀을 때 동작
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => NewTBackScreen(
                    tripTitle: widget.tripTitle, 
                    rangeStart: _rangeStart!, 
                    rangeEnd: _rangeEnd!,
                  ),
                ),
              );
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

  Widget _buildDatePage() {
    final List<String> monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행 기간을 선택해주세요!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 40,),
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
                    _updateNextButtonState(); // 날짜 선택 후 버튼 상태 업데이트
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
                      _updateNextButtonState(); // 날짜 선택 후 버튼 상태 업데이트
                    }
                  });
                },
                headerStyle: HeaderStyle(
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.zero,
                  formatButtonVisible: false,
                  titleTextFormatter: (date, locale) {
                    return "${monthNames[date.month - 1]} ${date.year}";
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
          _buildDatePage(),
          const Spacer(),
          _buildPNButton(),
          const SizedBox(height: 60,),
        ],
      ),
    );
  }
}
