import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('비밀번호 찾기'),
        ),
        body: PasswordScreen(),
      ),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 210)),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('옵써',
                      style: TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NanumMyeongjo',
                        color: Colors.black,
                      )),
                  Text('비밀번호 찾기',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text('비밀번호를 찾고자하는 아이디를 입력하세요.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF626262),
                  )),
                  Text('가입하신 이메일로 메일이 갑니다.',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF626262),
                      )),
                  SizedBox(height: 10.0,),
                  TextField(
                    cursorColor: Color(0xFF497F5B),
                    decoration: InputDecoration(
                      labelText: '이메일을 입력해 주세요.',
                      labelStyle: TextStyle(color: Color(0xFF8F9098),),
                      floatingLabelStyle: TextStyle(color: Color(0xFF1F2024),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC5C6CC),),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF497F5B),),
                        borderRadius: BorderRadius.circular(15.0),
                      ),),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10.0,),
                  ButtonTheme(
                      minWidth: 160.0,
                      height: 42.0,
                      child: ElevatedButton(
                        onPressed: (){
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(160, 52),
                            backgroundColor: Color(0xFF497F5B)
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: '이메일 보내기',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          ),
                        ),
                      )
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}