import 'dart:convert'; // Base64 변환을 위해 필요
import 'dart:io'; // File 클래스를 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 갤러리에서 이미지를 선택하기 위해 필요
import 'package:http/http.dart' as http; // 서버로 POST 요청을 보내기 위해 필요

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image; // 선택된 이미지를 저장하는 변수
  final ImagePicker _picker = ImagePicker(); // 이미지 선택을 위한 ImagePicker
  final TextEditingController _textController = TextEditingController(); // 텍스트 입력을 위한 컨트롤러
  final TextEditingController _boxTextController = TextEditingController(); // 텍스트 입력을 위한 컨트롤러

  // ### 갤러리에서 이미지를 선택하는 함수 ###
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지를 선택

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 선택된 이미지 파일을 _image에 저장
      });
    } else {
      print('이미지를 선택하지 않았습니다.');
    }
  }

  // ### 이미지를 Base64로 변환하는 함수 ###
  String _base64Encode(File image) {
    List<int> imageBytes = image.readAsBytesSync(); // 이미지 파일을 바이트로 변환
    String base64String = base64Encode(imageBytes); // 바이트를 Base64 문자열로 변환
    return base64String;
  }

  // ### 서버로 이미지 업로드 요청을 보내는 함수 ###
  Future<void> _uploadImage() async {
    if (_image == null) {
      print('이미지가 선택되지 않았습니다.');
      return;
    }

    String base64Image = _base64Encode(_image!); // 이미지를 Base64로 인코딩
    String fileName = _image!.path.split('/').last; // 파일 이름 가져오기

    try {
      var response = await http.post(
        Uri.parse('http://yourserver.com/upload'), // 여기에 실제 서버 주소를 입력
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'image': base64Image, // Base64 인코딩된 이미지
          'name': fileName, // 이미지 파일 이름
          'description': _textController.text, // 사용자가 입력한 텍스트도 서버로 전송
        }),
      );

      if (response.statusCode == 200) {
        print('이미지가 성공적으로 업로드되었습니다.');
      } else {
        print('업로드 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('업로드 중 오류 발생: $e');
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
        padding: const EdgeInsets.symmetric(horizontal: 60), // 좌우에 60만큼 패딩 추가
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '날짜',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
              // 텍스트 입력 칸 추가
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
                    borderSide: BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 3.0, // 테두리 두께를 3.0으로 설정
                    ),
                  ),
                  hintText: '2024.10.04', // 힌트 텍스트를 20241004로 설정
                  hintStyle: TextStyle(color: Color(0xFF8F9098)),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '장소',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
              // 장소 입력 텍스트 필드 추가
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
                    borderSide: BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 3.0, // 테두리 두께를 3.0으로 설정
                    ),
                  ),
                  hintText: '장소 또는 주소를 입력하세요', // 힌트 텍스트 설정
                  hintStyle: TextStyle(color: Color(0xFF8F9098)),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '사진 추가',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
              // 사진 추가 박스
              GestureDetector(
                onTap: _pickImage, // 클릭 시 이미지 선택
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black, // 박스 테두리 색상
                      width: 1.0, // 박스 테두리 두께
                    ),
                  ),
                  child: _image == null
                      ? Center(
                          child: Icon(
                            Icons.upload, // 업로드 아이콘 설정
                            size: 30,
                            color: Colors.grey,
                          ),
                        )
                      : Image.file(_image!, fit: BoxFit.cover), // 이미지가 선택되면 화면에 표시
                ),
              ),
              SizedBox(height: 20),
              // 새로운 박스 디자인의 텍스트 입력칸
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '메모',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 10),
              Container(
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
                  child: TextField(
                    controller: _boxTextController,
                    maxLines: null, // 여러 줄 입력 가능
                    expands: true, // 텍스트 필드가 컨테이너의 높이에 맞게 확장
                    decoration: InputDecoration(
                      border: InputBorder.none, // 내부에서 따로 테두리를 그리지 않음
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 등록하기 버튼
              Center(
                child: ElevatedButton(
                  onPressed: _uploadImage, // 등록 버튼을 눌렀을 때 이미지 업로드 실행
                  child: Text('등록하기', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    backgroundColor: const Color(0xFFFFC04B), // 버튼 배경색
                    foregroundColor: const Color(0xFFFFFFFF), // 버튼 텍스트 색상
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    minimumSize: const Size(130, 50), // 버튼 크기 설정
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
