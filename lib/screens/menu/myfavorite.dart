// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  List<int> selectedPlaces = []; // 선택된 관심장소의 인덱스 리스트
  List<String> selectedPlaceNames = []; // 선택된 장소의 이름 리스트
  List<Map<String, String>> favoritePlaces = [];

  // 카테고리 버튼 클릭 시 호출되는 함수
  void onCategoryTap(String category) {
    setState(() {
      selectedCategory = category; // 선택된 카테고리를 업데이트
    });
  }

  void onPlaceTap(int index) {
  setState(() {
    if (selectedPlaces.contains(index)) {
      // 이미 선택된 경우 선택 취소
      selectedPlaces.remove(index);
      selectedPlaceNames.remove(favoritePlaces[index]['name']);
    } else {
      // 선택되지 않은 경우 선택 추가
      selectedPlaces.add(index);
      selectedPlaceNames.add(favoritePlaces[index]['name']!);
    }
  });
}


  /* ### 서버에서 여행 데이터를 받아오는 함수 ### */
  Future<void> fetchPlaceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    
    final response = await http.get(
      Uri.parse('http://3.37.197.251:5000/mytrip/myplace'),
      headers: {'Authorization': 'Bearer $token'},
    ); // 서버 요청
    
    if (response.statusCode == 200) {
      // 응답 성공시, 데이터를 파싱하고 Map<String, String>으로 변환
      List<dynamic> data = json.decode(response.body)['data'];
      List<Map<String, String>> travelData = data.map((item) {
        return {
          'name': item['name'].toString(),   // String으로 변환
          'tags': item['tags'].toString(),
          'image': item['image'].toString(),
        };
      }).toList();

      setState(() {
        favoritePlaces = travelData; // favoritePlaces 리스트를 업데이트
        isLoading = false;  // 로딩 완료
      });
    } else {
      throw Exception('Failed to load travel data');
    }
  }


  // Base64 문자열을 이미지로 디코딩하는 함수
  Image imageFromBase64String(String base64String) {
    Uint8List imageBytes = base64Decode(base64String);
    return Image.memory(imageBytes, fit: BoxFit.cover);
  }

  /* ### 서버에 관심 장소를 저장하는 POST 요청 함수 ### */
  Future<void> removePlaces() async {
    List<String> selectedPlaceTitles = selectedPlaces.map((index) {
      return favoritePlaces[index]['title']!; // 선택된 장소들의 제목을 추출
    }).toList();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/mytrip/myplace'), // 서버의 POST 경로
        headers: {'Content-Type': 'application/json'}, // JSON으로 전송
        body: jsonEncode({
          'delete_table': selectedPlaceTitles, // 선택된 장소 제목 리스트를 서버에 전송
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 저장되었을 때
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('관심 장소가 성공적으로 삭제되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('삭제 실패: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('서버에 문제가 있습니다. 나중에 다시 시도해 주세요.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('오류가 발생했습니다. 다시 시도해 주세요.')),
      );
    }
  }

  /* ### 페이지 로드 시 서버에서 데이터 가져오기 ### */
  @override
  void initState() {
    super.initState();
    fetchPlaceData().then((data) {
      if (mounted) {
        setState(() {
          // travelCards = data; // 서버에서 받은 데이터 저장
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
              // GestureDetector(
              //   onTap: () => onCategoryTap('매거진'), // '매거진' 카테고리 선택
              //   child: CategoryButton(label: '매거진', isSelected: selectedCategory == '매거진'),
              // ),
              GestureDetector(
                onTap: () => onCategoryTap('상품'), // '상품' 카테고리 선택
                child: CategoryButton(label: '상품', isSelected: selectedCategory == '상품'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          selectedCategory == '전체' ? _buildGridFavoritePlaces() : Container(),
        ],
      ),
    );
  }

  // 관심장소 이미지 카드 UI
Widget _buildFavoritePlaceCard({
  required String cate,
  required String title,
  required String base64Image,
  required bool isSelected,
  required int index, // 인덱스를 추가
}) {
  return GestureDetector(
    onTap: () => onPlaceTap(index), // 인덱스를 직접 전달
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // 카드 모서리 둥글게
        side: isSelected
            ? const BorderSide(color: Color(0xFFFFC04B), width: 10)
            : BorderSide.none, // 선택된 카드에만 테두리 추가
      ),
      elevation: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // 이미지 모서리 둥글게
        child: Stack(
          children: [
            // Base64 문자열을 디코딩하여 이미지 표시
            imageFromBase64String(base64Image),
            // 이미지에 BoxFit.cover 적용해서 카드 내에서 이미지를 꽉 채우기
            Positioned.fill(
              child: Image.memory(
                base64Decode(base64Image),
                fit: BoxFit.cover, // 이미지를 카드 크기 내에 꽉 채우기
              ),
            ),
            // 텍스트와 그라데이션
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center, // 그라데이션 시작점
                  end: Alignment.bottomCenter, // 그라데이션 끝점
                  colors: [
                    Colors.transparent, // 상단은 투명
                    Colors.black.withOpacity(1), // 하단은 검정색, 투명도 1
                  ],
                ),
              ),
              alignment: Alignment.bottomLeft, // 텍스트를 왼쪽 아래로 배치
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // 텍스트가 아래쪽에 위치하도록 설정
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 6),
                    child: Text(
                      cate,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white), // 카테고리 텍스트
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white), // 제목 텍스트
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

  // 새로운 관심장소 카드를 그리드 형식으로 보여주는 GridView
  Widget _buildGridFavoritePlaces() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 60), // 하단에 50의 여백 추가
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2열로 설정
          crossAxisSpacing: 10, // 좌우 간격
          mainAxisSpacing: 10, // 상하 간격
          childAspectRatio: 1, // 이미지의 가로 세로 비율
        ),
        itemCount: favoritePlaces.length, // 관심장소 데이터 개수
        itemBuilder: (context, index) {
          final place = favoritePlaces[index];
          return _buildFavoritePlaceCard(
            cate: place['tags']!, // 카테고리 추가
            title: place['name']!,
            base64Image: place['image']!, // Base64 인코딩된 이미지 사용
            isSelected: selectedPlaces.contains(index), // 선택된 인덱스에 해당하는 카드에만 테두리 표시
            index: index, // 인덱스를 전달
          );
        },
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
