import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Stack(
              children: [
                Positioned(
                  left: 15, 
                  top: 5, 
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Color(0xFF000000), size: 24,),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('계정 설정', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 60, 40, 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () {
                          // 여기에 원하는 동작 추가
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 프로필 사진 변경', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 여기에 원하는 동작 추가
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 로그아웃', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 여기에 원하는 동작 추가
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 회원 탈퇴', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

