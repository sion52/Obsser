import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isChecked = false;

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
                    Text('알림 설정', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)
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
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F1EA),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('야간 수신',style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),),
                                      Text("""야간(21:00~08:00)에 광고성 푸시\n알림을 받을 수 있습니다.""", style: TextStyle(fontSize: 15,color: Color(0xFF727272)),),
                                    ],
                                  ),
                                ],
                              ),
                              CupertinoSwitch( 
                                  value: _isChecked,
                                  activeColor: CupertinoColors.activeGreen,
                                  onChanged: (bool? value) { 
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F1EA),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("""정보성 푸시 알림은 위 설정 여부와는 무관\n하게 받을 수 있습니다. 기기의 알림 설정은\n'휴대폰 설정 > 알림 > 옵써'에서 변경 할\n수 있습니다.""", style: TextStyle(fontSize: 15,color: Color(0xFF000000)),),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Icon(Icons.arrow_forward_ios, size: 25,),
                              ),
                            ],
                          ),
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

