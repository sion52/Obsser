import 'dart:convert'; // Base64 변환을 위해 필요
import 'dart:io'; // File 클래스를 사용하기 위해 필요
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _commentController = TextEditingController(); // 댓글 입력을 위한 컨트롤러
  List<String> _comments = []; // 댓글을 저장하는 리스트

  // 댓글 추가 함수
  void _addComment(String comment) {
    if (comment.isNotEmpty) {
      setState(() {
        _comments.add(comment); // 댓글 리스트에 추가
      });
      _commentController.clear(); // 입력 필드 초기화
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // 툴바 높이 설정
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20), // 좌우에 60만큼 패딩 추가
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close), // 엑스 아이콘 설정
                ),
              ),
              // 에셋 이미지 카드 추가
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
                ),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/pictures/veke.png', // 여기에 에셋 이미지 경로를 입력
                      fit: BoxFit.cover, // 이미지가 박스에 맞게 표시되도록 설정
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text('2024.10.04 방문', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text('베케', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black, // 박스 테두리 색상
                      width: 1.0, // 박스 테두리 두께
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '생각하는 정원에 방문하였습니다. 한적하고 고요하여 정말 조형물과 식재에 대해 깊이 빠져 사유하는 시간을 가질 수 있었습니다. 다들 한 번씩 방문하시면 좋겠습니다~', 
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 댓글 목록
              Expanded(
                child: ListView.builder(
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                          _comments[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // 댓글 입력 필드 및 버튼
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          labelText: '댓글 입력',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _addComment(_commentController.text), // 댓글 추가 함수 호출
                      child: Text('등록'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
