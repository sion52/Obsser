import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/notice.dart';
import 'package:obsser_1/screens/menu/notification.dart';
import 'package:obsser_1/screens/menu/setting.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children:[
          Padding(
            padding: EdgeInsets.fromLTRB(40, 100, 40, 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F1EA),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/profile.png',width: 50,height: 50,),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('로그인하세요',style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),),
                                Text('', style: TextStyle(fontSize: 12,color: Color(0xFF727272)),),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => SettingScreen()
                              ),
                            );
                          },
                          child: Icon(Icons.settings_outlined, size: 40,),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            Text(' 나의 관심장소', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
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
                            Text(' 나의 일정', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 3,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => NoticeScreen()
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 공지사항', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen()
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 알림 설정', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 1:1 문의 Row 클릭 시 동작
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 1:1 문의', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 서비스 약관 Row 클릭 시 동작
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 서비스 약관', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 앱버전 Row 클릭 시 동작
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 앱버전', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          // 로그아웃 Row 클릭 시 동작
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          children: [
                            Text(' 로그아웃', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                            Icon(Icons.arrow_forward_ios,),
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

