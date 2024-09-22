import 'package:flutter/material.dart';

class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

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
                    Text('공지사항', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' 문의 내역', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 350,
            height: 3,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
          ),
        ],
      ),
    );
  }
}

