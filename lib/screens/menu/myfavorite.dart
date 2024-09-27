import 'package:flutter/material.dart';

/* ##### 관심 목록 화면 ##### */
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String selectedCategory = "전체"; // 선택된 카테고리를 저장하는 변수

  // 카테고리 버튼 클릭 시 호출되는 함수
  void onCategoryTap(String category) {
    setState(() {
      selectedCategory = category; // 선택된 카테고리를 업데이트
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
