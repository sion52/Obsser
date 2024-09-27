import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* ##### 관심 목록 화면 ##### */
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String selectedCategory = "전체"; // 선택된 카테고리를 저장하는 변수
  List<Map<String, String>> travelCards = []; // 서버에서 받아온 여행 카드 데이터 저장
  bool isLoading = true; // 로딩 상태 표시 변수

  // 카테고리 버튼 클릭 시 호출되는 함수
  void onCategoryTap(String category) {
    setState(() {
      selectedCategory = category; // 선택된 카테고리를 업데이트
    });
  }

  /* ### 서버에서 여행 데이터를 받아오는 함수 ### */
  Future<List<Map<String, String>>> fetchPlaceData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/mytrip/myplace')); // 서버 요청

    if (response.statusCode == 200) {
      // 응답 성공시, 데이터를 파싱하고 Map<String, String>으로 변환
      List<dynamic> data = json.decode(response.body);
      List<Map<String, String>> travelData = data.map((item) {
        return {
          'title': item['title'].toString(),   // String으로 변환
          'date': item['date'].toString(),
          'imageUrl': item['imageUrl'].toString(),
        };
      }).toList();

      return travelData;
    } else {
      throw Exception('Failed to load travel data');
    }
  }

  /* ### 페이지 로드 시 서버에서 데이터 가져오기 ### */
  @override
  void initState() {
    super.initState();
    fetchPlaceData().then((data) {
      if (mounted) {
        setState(() {
          travelCards = data; // 서버에서 받은 데이터 저장
          isLoading = false;  // 로딩 완료
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false; // 오류 발생 시에도 로딩 완료 상태로 설정
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 흰색
      body: Column(
        children: [
          /* ### 상단 네비게이션 바 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 20), // 상단 패딩 설정
            child: Stack(
              children: [
                /* ### 뒤로가기 버튼 ### */
                Positioned(
                  left: 15,
                  top: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // 이전 화면으로 돌아가기
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF000000),
                      size: 24,
                    ),
                  ),
                ),
                /* ### 제목 표시 ### */
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 제목을 중앙에 배치
                  children: [
                    Text(
                      '나의 관심', // 타이틀 텍스트
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /* ### 카테고리 버튼 그룹 ### */
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 카테고리 버튼을 중앙에 정렬
            children: [
              GestureDetector(
                onTap: () => onCategoryTap('전체'), // '전체' 카테고리 선택
                child: CategoryButton(label: '전체', isSelected: selectedCategory == '전체'),
              ),
              GestureDetector(
                onTap: () => onCategoryTap('관광'), // '관광' 카테고리 선택
                child: CategoryButton(label: '관광', isSelected: selectedCategory == '관광'),
              ),
              GestureDetector(
                onTap: () => onCategoryTap('식당'), // '식당' 카테고리 선택
                child: CategoryButton(label: '식당', isSelected: selectedCategory == '식당'),
              ),
              GestureDetector(
                onTap: () => onCategoryTap('카페'), // '카페' 카테고리 선택
                child: CategoryButton(label: '카페', isSelected: selectedCategory == '카페'),
              ),
              GestureDetector(
                onTap: () => onCategoryTap('매거진'), // '매거진' 카테고리 선택
                child: CategoryButton(label: '매거진', isSelected: selectedCategory == '매거진'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ##### 카테고리 버튼 위젯 ##### */
class CategoryButton extends StatelessWidget {
  final String label; // 카테고리 이름
  final bool isSelected; // 선택된 상태인지 여부

  const CategoryButton({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0), // 버튼 사이 간격 설정
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0), // 버튼 내부 패딩
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF497F5B) : const Color(0xFFE8F1EA), // 선택 상태에 따른 배경색 변경
          borderRadius: BorderRadius.circular(15.0), // 버튼 모서리 둥글게 설정
        ),
        child: Text(
          label, // 카테고리 이름
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF626262), // 선택 상태에 따른 텍스트 색상 변경
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, // 선택 상태에 따른 텍스트 굵기 변경
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
