import 'package:flutter/material.dart';
import 'package:obsser_1/screens/login.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Center(
            child: Text('Menu 화면', style: TextStyle(fontSize: 24)),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
              },
              child: Text(
                '로그인 화면',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 18),
                backgroundColor: Color(0xFF497F5B),
                foregroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(170, 55),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
