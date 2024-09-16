import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTBackScreen extends StatefulWidget {
  final String tripTitle;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  const NewTBackScreen({super.key, required this.tripTitle, required this.rangeStart, required this.rangeEnd});

  @override
  // ignore: library_private_types_in_public_api
  _NewTBackScreenState createState() => _NewTBackScreenState();
}

class _NewTBackScreenState extends State<NewTBackScreen> {
  bool isNextEnabled = false; // 다음 버튼 활성화 여부
  
  void _updateNextButtonState() {
  }

  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFC5C6CC),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('이전', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        ),
        const SizedBox(width: 25,),
        ElevatedButton(
          onPressed: isNextEnabled
            ? () {
              // 다음 버튼 눌렀을 때 동작
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

  Widget _buildDatePage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행에 어울리는 이미지를 선택해주세요!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 40,),
          
          Text(
            '${widget.tripTitle} ${DateFormat('yyyy.MM.dd').format(widget.rangeStart)} - ${DateFormat('yyyy.MM.dd').format(widget.rangeEnd)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          _buildDatePage(),
          const Spacer(),
          _buildPNButton(),
          const SizedBox(height: 60,),
        ],
      ),
    );
  }
}
