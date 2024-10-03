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
      appBar: AppBar(
        title: Text('이미지 업로드'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('이미지를 선택해 주세요')
                : Image.file(_image!), // 선택한 이미지가 있으면 화면에 표시
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage, // 이미지 선택 함수 호출
              child: Text('갤러리에서 이미지 선택'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage, // 이미지 업로드 함수 호출
              child: Text('이미지 업로드'),
            ),
          ],
        ),
      ),
    );
  }
}
