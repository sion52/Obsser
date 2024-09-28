import 'package:flutter/material.dart';

/* ##### 문의 화면 ##### */
class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 흰색
      body: SingleChildScrollView( // 스크롤 가능하도록 SingleChildScrollView로 감싸기
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 20), // 상단 및 양옆 패딩 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* ### 상단 네비게이션 바 ### */
              Stack(
                children: [
                  /* ### 뒤로가기 버튼 ### */
                  Positioned(
                    left: 15,
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // 뒤로가기 동작
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF000000),
                        size: 24,
                      ),
                    ),
                  ),
                  /* ### 페이지 제목 ### */
                  const Center(
                    child: Text(
                      '1:1 문의', // 페이지 제목
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              /* ### 문의 내역 섹션 ### */
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: GestureDetector(
                  onTap: () {
                    // 여기에 원하는 동작 추가
                  },
                  /* ### 문의 내역 항목 ### */
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                    children: [
                      Text(
                        '문의 내역', // 문의 내역 텍스트
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios, // 우측 화살표 아이콘
                      ),
                    ],
                  ),
                ),
              ),
              /* ### 구분선 ### */
              Align(
                alignment: Alignment.center, // 구분선을 가운데 정렬
                child: Container(
                  width: 350, // 구분선 너비를 350으로 설정
                  height: 3, // 구분선 높이
                  color: const Color(0xFFD9D9D9), // 구분선 색상
                ),
              ),
              const SizedBox(height: 30),
              /* ### 문의 내용 입력 섹션 ### */
              Padding( // 여기에 padding 추가
                padding: const EdgeInsets.symmetric(horizontal: 30), // 원하는 대로 간격 설정
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1EA), // 배경색
                    borderRadius: BorderRadius.circular(15), // 모서리 둥글게
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '문의 하기', // 제목
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      /* ### 제목 입력 필드 ### */
                      const TextField(
                        decoration: InputDecoration(
                          hintText: '제목을 입력해 주세요.', // labelText 대신 hintText 사용
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      /* ### 내용 입력 필드 ### */
                      const TextField(
                        maxLines: 5, // 내용은 여러 줄 입력 가능
                        decoration: InputDecoration(
                          hintText: '문의 내용을 입력해 주세요.', // labelText 대신 hintText 사용
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      /* ### 사진 추가 및 등록 버튼 ### */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                        children: [
                          IconButton(
                            onPressed: () {
                              // 사진 추가 동작
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                            iconSize: 30, // 아이콘 크기 설정
                            color: const Color(0xFF121212), // 아이콘 색상
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 등록하기 동작
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black, backgroundColor: const Color(0xFFFFFFFF), // 텍스트 색상
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글게
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 버튼 패딩
                            ),
                            child: const Text('등록하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text('‘옵써’와 관련 없거나 부적합한 사진을 등록하시는 경우, 사전 예고 없이 사진 및 내용이 삭제될 수 있습니다', style: TextStyle(color: Color(0xFF727272)),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
