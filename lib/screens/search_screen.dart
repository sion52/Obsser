import 'package:flutter/material.dart';

/* ##### 공지사항 화면 ##### */
class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // TextEditingController에 query 값을 설정
    final TextEditingController searchController = TextEditingController(text: query);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        children: [
          /* ### 상단 네비게이션 바 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 0), // 패딩 설정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소를 양 끝에 배치
              children: [
                /* ### 뒤로가기 버튼 ### */
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 뒤로가기 동작
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF000000),
                    size: 24,
                  ),
                ),
                /* ### 검색 필드 ### */
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  width: 300,
                  height: 30,
                  child: TextField(
                    controller: searchController, // 검색창에 query 설정
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none, // 테두리 없음
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF2F2F2), // 배경색 회색
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.search, size: 24, color: Color(0xFF000000)),
                        onPressed: () {
                          // 검색 버튼 클릭 시 동작
                        },
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0), // 수직 패딩 조정
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
