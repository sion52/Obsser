import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/login.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          const Center(
            child: Text('Menu 화면', style: TextStyle(fontSize: 24)),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 18),
                backgroundColor: const Color(0xFF497F5B),
                foregroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: const Size(170, 55),
                elevation: 0,
              ),
              child: const Text(
                '로그인 화면',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
