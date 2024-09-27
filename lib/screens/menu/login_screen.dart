import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/password_screen.dart';
import 'package:obsser_1/screens/menu/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* ##### 로그인 화면 ##### */
class LogIn extends StatefulWidget {
  final Function onLogin; // 로그인 성공 후 호출되는 콜백 함수

  const LogIn({super.key, required this.onLogin});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isObscured = true; // 비밀번호 가리기 상태
  final TextEditingController emailController = TextEditingController(); // 이메일 입력 필드 컨트롤러
  final TextEditingController passwordController = TextEditingController(); // 비밀번호 입력 필드 컨트롤러
  String? message; // 오류 메시지

  /* ### 로그인 서버 요청 함수 ### */
  Future<void> checkLogin() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = '이메일과 비밀번호를 모두 입력해 주세요.'; // 이메일 또는 비밀번호가 비어있을 때
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/auth/login'), // 서버 URL로 POST 요청
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success']) {
          widget.onLogin(); // 로그인 성공 시 콜백 호출
          // ignore: use_build_context_synchronously
          Navigator.pop(context); // 로그인 성공 후 이전 화면으로 돌아감
        } else {
          setState(() {
            message = responseData['message'] ?? '로그인에 실패했습니다.'; // 로그인 실패 메시지
          });
        }
      } else {
        setState(() {
          message = '서버 연결에 문제가 있습니다. 나중에 다시 시도해 주세요.'; // 서버 응답 실패 시
        });
      }
    } catch (error) {
      setState(() {
        message = '로그인 중 오류가 발생했습니다.'; // 예외 발생 시 오류 메시지
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 흰색
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 250)), // 상단 여백
          /* ### 앱 이름 표시 ### */
          const Center(
            child: Text(
              '옵써',
              style: TextStyle(
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'NanumMyeongjo',
                color: Colors.black,
              ),
            ),
          ),
          /* ### 입력 및 버튼 ### */
          Form(
            child: Theme(
              data: ThemeData(), // 테마 데이터 적용
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /* ### 이메일 입력 필드 ### */
                      TextField(
                        controller: emailController,
                        cursorColor: const Color(0xFF497F5B),
                        decoration: InputDecoration(
                          labelText: '이메일을 입력해 주세요.',
                          labelStyle: const TextStyle(color: Color(0xFF8F9098)),
                          floatingLabelStyle: const TextStyle(color: Color(0xFF1F2024)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFC5C6CC), width: 1.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF497F5B), width: 1.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15.0),
                      /* ### 비밀번호 입력 필드 ### */
                      TextField(
                        controller: passwordController,
                        cursorColor: const Color(0xFF497F5B),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured; // 비밀번호 가리기 상태 변경
                              });
                            },
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFFB3B3B3),
                            ),
                          ),
                          labelText: '비밀번호를 입력해 주세요.',
                          labelStyle: const TextStyle(color: Color(0xFF8F9098)),
                          floatingLabelStyle: const TextStyle(color: Color(0xFF1F2024)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFC5C6CC), width: 1.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF497F5B), width: 1.3),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        obscureText: _isObscured, // 비밀번호 숨김 처리
                      ),
                      const SizedBox(height: 20.0),
                      /* ### 오류 메시지 표시 ### */
                      if (message != null)
                        Text(
                          message!,
                          style: const TextStyle(fontSize: 16.0, color: Color(0xFFED3241)),
                        ),
                      const SizedBox(height: 20.0),
                      /* ### 로그인 버튼 ### */
                      ButtonTheme(
                        minWidth: 160.0,
                        height: 42.0,
                        child: ElevatedButton(
                          onPressed: checkLogin, // 로그인 시도 함수 호출
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(160, 52),
                            backgroundColor: const Color(0xFF497F5B), // 버튼 색상
                          ),
                          child: const Text(
                            '로그인',
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      /* ### 비밀번호 찾기 링크 ### */
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PasswordScreen()),
                          );
                        },
                        child: const Center(
                          child: Text(
                            '비밀번호를 잊으셨나요?',
                            style: TextStyle(fontSize: 16.0, color: Color(0xFF626262)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      /* ### 계정 생성 링크 ### */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '계정이 없으신가요? ',
                            style: TextStyle(fontSize: 16.0, color: Color(0xFF626262)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupScreen()),
                              );
                            },
                            child: const Text(
                              '가입하기',
                              style: TextStyle(fontSize: 16.0, color: Color(0xFF488A5F)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
