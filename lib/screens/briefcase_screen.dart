import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BriefcaseScreen extends StatefulWidget {
  const BriefcaseScreen({Key? key}) : super(key: key);

  @override
  _BriefcaseScreenState createState() => _BriefcaseScreenState();
}

class _BriefcaseScreenState extends State<BriefcaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 50, 38, 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2024,1,1),
                  lastDay: DateTime(2024,12,31),
                  locale: 'ko-KR',
                  daysOfWeekHeight: 50,
                  
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Color(0xFF494A50), fontWeight: FontWeight.bold),
                    weekendTextStyle: TextStyle(color: Color(0xFF494A50), fontWeight: FontWeight.bold),
                    outsideDaysVisible: true,
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF85C59A),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: Color(0xFFFFFFFF)
                    ),
                    rowDecoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}