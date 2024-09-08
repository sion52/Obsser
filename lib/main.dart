import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/dol_screen.dart';
import 'screens/hash_screen.dart';
import 'screens/briefcase_screen.dart';
import 'screens/menu_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0: return DolScreen();
      case 1: return HashScreen();
      case 2: return BriefcaseScreen();
      case 3: return MenuScreen();
      default: return Container();
    }
  }

  Widget _buildIcon(String assetName, int index, {double width = 32, double height = 32}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SvgPicture.asset(
        assetName,
        color: _currentIndex == index ? Color(0xFF477C59) : Color(0xFF284029),
        width: width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF8F8F8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildIcon('assets/icons/Dol.svg', 0, width: 90, height: 90),
            SizedBox(width: 50),
            _buildIcon('assets/icons/Hash.svg', 1),
            SizedBox(width: 60),
            _buildIcon('assets/icons/Briefcase.svg', 2),
            SizedBox(width: 60),
            _buildIcon('assets/icons/Menu.svg', 3),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
