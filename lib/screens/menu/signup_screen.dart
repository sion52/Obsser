import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* ##### 회원가입 화면 ##### */
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscured = true; // 비밀번호 가림 여부
  final TextEditingController password2Controller = TextEditingController(); // 비밀번호 컨트롤러
  final TextEditingController confirmPasswordController = TextEditingController(); // 비밀번호 확인 컨트롤러
  final TextEditingController name3Controller = TextEditingController(); // 이름 컨트롤러
  final TextEditingController email3Controller = TextEditingController(); // 이메일 컨트롤러

  bool? isMatching; // 비밀번호 일치 여부 확인
  String errorMessage = ''; // 오류 메시지
  String successMessage = ''; // 성공 메시지

  // ### 서버로 회원가입 요청을 보내는 함수 ###
  Future<void> _signup() async {
    // 입력된 값이 모두 있는지 확인
    if (name3Controller.text.isEmpty ||
        email3Controller.text.isEmpty ||
        password2Controller.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      setState(() {
        errorMessage = '모든 항목을 입력하세요.';
        successMessage = '';
      });
      return;
    }

    // 비밀번호가 일치하는지 확인
    if (!isMatching!) {
      setState(() {
        errorMessage = '비밀번호가 일치하지 않습니다.';
        successMessage = '';
      });
      return;
    }

    try {
      // 서버에 POST 요청 보내기
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name3Controller.text,
          'password': password2Controller.text,
          'email': email3Controller.text,
        }),
      );

      // 서버 응답 확인
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['result'] == 'success') {
          setState(() {
            successMessage = '회원가입에 성공했습니다!';
            errorMessage = '';
          });
          // 회원가입 성공 후 처리
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          setState(() {
            errorMessage = responseData['message'] ?? '회원가입에 실패했습니다.';
            successMessage = '';
          });
        }
      } else {
        setState(() {
          errorMessage = '서버 연결에 문제가 발생했습니다. 나중에 다시 시도해 주세요.';
          successMessage = '';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = '회원가입 중 오류가 발생했습니다.';
        successMessage = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // 비밀번호와 비밀번호 확인 필드 값 비교
    password2Controller.addListener(_checkPasswordMatch);
    confirmPasswordController.addListener(_checkPasswordMatch);
  }

  // ### 비밀번호와 비밀번호 확인 필드 비교 함수 ###
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
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 흰색
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 250)), // 상단 여백
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ### 이름 입력 ### */
                const Text('이름',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 10.0),
                TextField(
                  controller: name3Controller, // 이름 입력 컨트롤러
                  cursorColor: const Color(0xFF497F5B),
                  decoration: InputDecoration(
                    hintText: '이름',
                    hintStyle: const TextStyle(color: Color(0xFF8F9098)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC5C6CC)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF497F5B)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 25.0),

                /* ### 이메일 입력 ### */
                const Text('이메일',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 10.0),
                TextField(
                  controller: email3Controller, // 이메일 입력 컨트롤러
                  cursorColor: const Color(0xFF497F5B),
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: const TextStyle(color: Color(0xFF8F9098)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC5C6CC)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF497F5B)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25.0),

                /* ### 비밀번호 입력 ### */
                const Text('비밀번호',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 10.0),
                TextField(
                  controller: password2Controller, // 비밀번호 입력 컨트롤러
                  cursorColor: const Color(0xFF497F5B),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured; // 비밀번호 가리기 상태 토글
                        });
                      },
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF8F9098),
                      ),
                    ),
                    hintText: '비밀번호',
                    hintStyle: const TextStyle(color: Color(0xFF8F9098)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC5C6CC)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF497F5B)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  obscureText: _isObscured, // 비밀번호 가리기
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10.0),

                /* ### 비밀번호 확인 입력 ### */
                TextField(
                  controller: confirmPasswordController, // 비밀번호 확인 컨트롤러
                  cursorColor: const Color(0xFF497F5B),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
                    suffixIcon: isMatching == null
                        ? null // 값이 입력되지 않으면 아이콘 없음
                        : Icon(
                            isMatching!
                                ? Icons.check // 일치하면 체크 아이콘
                                : Icons.close, // 일치하지 않으면 닫기 아이콘
                            color: isMatching! ? Colors.green : Colors.red,
                          ),
                    hintStyle: const TextStyle(color: Color(0xFF8F9098)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC5C6CC)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF497F5B)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20.0),

                /* ### 가입 버튼 ### */
                Center(
                  child: ButtonTheme(
                    minWidth: 160.0,
                    height: 42.0,
                    child: ElevatedButton(
                      onPressed: _signup, // 회원가입 함수 호출
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(160, 52),
                        backgroundColor: const Color(0xFF497F5B),
                      ),
                      child: const Text(
                        '가입하기',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                /* ### 오류 메시지 출력 ### */
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFED3241),
                      ),
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
