import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/password_screen.dart';
import 'package:obsser_1/screens/menu/signup_screen.dart';

class LogIn extends StatefulWidget {
  final Function onLogin;

  const LogIn({super.key, required this.onLogin});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isFocused = false;
  bool _isObscured = true;
  bool _isTapped1 = false;
  bool _isTapped2 = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? message;

  void checkLogin() {
    setState(() {
      if (emailController.text == 'sdf@gmail.com' && passwordController.text == '1234') {
        widget.onLogin();
        Navigator.pop(context);
      }
      else {
        message = '이메일 또는 비밀번호가 일치하지 않습니다.';
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 250)),
          Center(
            child: Text('옵써',
            style: TextStyle(
              fontSize: 64.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'NanumMyeongjo',
              color: Colors.black,
            )),
          ),
          Form(
              child: Theme(
                data: ThemeData(),
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            cursorColor: Color(0xFF497F5B),
                            decoration: InputDecoration(
                              labelText: '이메일을 입력해 주세요.',
                              labelStyle: TextStyle(color: Color(0xFF8F9098),),
                              floatingLabelStyle: TextStyle(color: Color(0xFF1F2024),),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFC5C6CC), width: 1.3),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF497F5B), width: 1.3),
                                borderRadius: BorderRadius.circular(15.0),
                              ),),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.0,),
                          TextField(
                            controller: passwordController,
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
                              labelText: '비밀번호를 입력해 주세요.',
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
                            obscureText: _isObscured,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.0,),
                          ButtonTheme(
                              minWidth: 160.0,
                              height: 42.0,
                              child: ElevatedButton(
                                onPressed: checkLogin,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(160, 52),
                                  backgroundColor: Color(0xFF497F5B)
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '로그인',
                                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 30.0,),
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                _isTapped1 = true;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                _isTapped1 = false;
                              });
                            },
                            onTap: () {
                              //비밀번호찾기페이지
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PasswordScreen())
                              );
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: 170,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: _isTapped1
                                    ? [
                                  BoxShadow(
                                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(3, 3), // 그림자의 위치
                                  ),
                                ]
                                    : [], // 그림자 없음
                              ),
                              child: Center(child: Text('비밀번호를 잊으셨나요?', style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF626262),
                              ),),),
                            ),
                          ),
                          SizedBox(height: 6.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('계정이 없으신가요?', style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF626262),
                              )),
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    _isTapped2 = true;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    _isTapped2 = false;
                                  });
                                },
                                onTap: () {
                                  //가입화면
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignupScreen())
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  width: 70,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: _isTapped2
                                        ? [
                                      BoxShadow(
                                        color: Color(0xFFF7F7F7).withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(3, 3), // 그림자의 위치
                                      ),
                                    ]
                                        : [], // 그림자 없음
                                  ),
                                  child: Center(child: Text('가입하기', style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF488A5F),
                                  ),),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          if (message != null)
                            Text(
                              message!,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFFED3241),
                              )
                            ),
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
