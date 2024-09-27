import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('회원가입하기'),
        ),
        body: SignupScreen(),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscured = true;
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController name3Controller = TextEditingController();
  final TextEditingController email3Controller = TextEditingController();

  bool? isMatching;
  String errorMessage = '';

  void _validateInputs() {
    setState(() {
      if (name3Controller.text.isEmpty ||
          email3Controller.text.isEmpty ||
          password2Controller.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        // 오류 메시지 설정
        errorMessage = '모든 항목을 입력하세요.';
      } else {
        // 모든 입력이 정상일 경우
        errorMessage = ''; // 오류 메시지 초기화
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage())
        );
        print('가입 성공!');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 텍스트필드 값 변경 시 비교 수행
    password2Controller.addListener(_checkPasswordMatch);
    confirmPasswordController.addListener(_checkPasswordMatch);
  }

  // 두 텍스트필드의 값을 비교하는 함수
  void _checkPasswordMatch() {
    setState(() {
      isMatching = password2Controller.text == confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    password2Controller.dispose();
    confirmPasswordController.dispose();
    name3Controller.dispose();
    email3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 60)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이름',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(height: 10.0,),
                TextField(
                  controller: name3Controller,
                  cursorColor: Color(0xFF497F5B),
                  decoration: InputDecoration(
                    hintText: '이름',
                    hintStyle: TextStyle(color: Color(0xFF8F9098),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC5C6CC),),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF497F5B),),
                      borderRadius: BorderRadius.circular(15.0),
                    ),),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 25.0,),
                Text('이메일',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(height: 10.0,),
                TextField(
                  controller: email3Controller,
                  cursorColor: Color(0xFF497F5B),
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: TextStyle(color: Color(0xFF8F9098),),
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
                SizedBox(height: 25.0,),
                Text('비밀번호',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(height: 10.0,),
                TextField(
                  controller: password2Controller,
                  cursorColor: Color(0xFF497F5B),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured; // 아이콘을 누를 때 상태 변경
                      });
                      //비번 가려짐.
                    },
                      icon: Icon(
                        _isObscured ? Icons.visibility: Icons.visibility_off,
                      ),),
                    hintText: '비밀번호',
                    hintStyle: TextStyle(color: Color(0xFF8F9098),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC5C6CC),),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF497F5B),),
                      borderRadius: BorderRadius.circular(15.0),
                    ),),
                  obscureText: _isObscured,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: confirmPasswordController,
                  cursorColor: Color(0xFF497F5B),
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: '비밀번호 확인',
                    suffixIcon: isMatching == null
                        ? null // 값이 입력되지 않으면 아무 아이콘도 없음
                        : Icon(
                      isMatching! ? Icons.check : Icons.close,
                      color: isMatching! ? Colors.green : Colors.red,
                    ),
                      hintStyle: TextStyle(color: Color(0xFF8F9098),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC5C6CC),),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF497F5B),),
                        borderRadius: BorderRadius.circular(15.0),
                      ),),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.0,),
                Center(
                  child: ButtonTheme(
                      minWidth: 160.0,
                      height: 42.0,
                      child: ElevatedButton(
                        onPressed: _validateInputs,
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(160, 52),
                            backgroundColor: Color(0xFF497F5B)
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: '가입하기',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFED3241),
                        )
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



