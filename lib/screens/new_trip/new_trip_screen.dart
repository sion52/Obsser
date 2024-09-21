import 'package:flutter/material.dart';
import 'package:obsser_1/screens/new_trip/new_trip_date.dart';

class NewTScreen extends StatefulWidget {
  const NewTScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewTScreenState createState() => _NewTScreenState();
}
class _NewTScreenState extends State<NewTScreen> {
  bool isNextEnabled = false; // 다음 버튼 활성화 여부
  final TextEditingController _controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // TextField 값 변경 시 호출
    _controller.addListener(() {
      setState(() {
        isNextEnabled = _controller.text.isNotEmpty; // 입력값이 비어있지 않으면 다음 버튼 활성화
      });
    });
  }

  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 170,),
        const SizedBox(width: 25,),
        ElevatedButton(
          onPressed: isNextEnabled
            ? () {
              // 다음 버튼 눌렀을 때 동작
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NewTDateScreen(tripTitle: _controller.text,)),
              );
            }
            : null, 
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), 
            foregroundColor: const Color(0xFFFFFFFF),
            disabledForegroundColor: const Color(0xFFFFFFFF), 
            disabledBackgroundColor: const Color(0xFFFFDEA0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('다음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        ),  
      ],
    );
  }

  Widget _buildTitlePage() {
    return Padding(
      padding:const EdgeInsets.fromLTRB(40, 150, 40, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행 제목을 입력하세요!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: const Color(0xFFC5C6CC),
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '힐링하러 떠나는 제주도',
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFFC5C6CC)),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.autorenew, size: 28, color: Color(0xFF477C59),),
                    onPressed: () {
                      // 검색 버튼 클릭 시 동작
                    },
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxWidth: 30,
                    maxHeight: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          _buildTitlePage(),
          const Spacer(),
          _buildPNButton(),
          const SizedBox(height: 60,),
        ],
      ),
    );
  }
}