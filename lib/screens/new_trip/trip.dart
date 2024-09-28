import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* ##### 여행 카드 상세보기 화면 ##### */
class TripScreen extends StatefulWidget {
  final int index;  // 선택된 카드의 인덱스
  const TripScreen({super.key, required this.index});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<Map<String, String>> travelCards = []; // 서버에서 받아온 여행 카드 데이터를 저장
  bool isLoading = true; // 로딩 상태 변수
  String selectedCategory = "관심장소"; // 선택된 카테고리를 저장하는 변수
  List<int> selectedPlaces = []; // 선택된 관심장소의 인덱스 리스트

  List<Map<String, String>> favoritePlaces = [
    {
      'title': '카멜리아 힐',
      'imageUrl': 'assets/pictures/camellia.png', // 로컬 이미지 경로
      'cate': '관광명소',
    },
    {
      'title': '생각하는 정원',
      'imageUrl': 'assets/pictures/garden.png', // 로컬 이미지 경로
      'cate': '관광명소',
    },
    {
      'title': '삼성혈',
      'imageUrl': 'assets/pictures/samsung.png', // 로컬 이미지 경로
      'cate': '관광명소',
    },
    {
      'title': '베케',
      'imageUrl': 'assets/pictures/veke.png', // 로컬 이미지 경로
      'cate': '관광명소',
    },
    {
      'title': '카멜리아 힐2',
      'imageUrl': 'assets/pictures/camellia.png', // 로컬 이미지 경로
      'cate': '식당',
    },
    {
      'title': '생각하는 정원2',
      'imageUrl': 'assets/pictures/garden.png', // 로컬 이미지 경로
      'cate': '카페',
    },
    {
      'title': '삼성혈2',
      'imageUrl': 'assets/pictures/samsung.png', // 로컬 이미지 경로
      'cate': '식당',
    },
    {
      'title': '베케2',
      'imageUrl': 'assets/pictures/veke.png', // 로컬 이미지 경로
      'cate': '카페',
    },
    // 필요한 만큼 데이터를 추가
  ];

  void onCategoryTap(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void onPlaceTap(int index) {
    setState(() {
      if (selectedPlaces.contains(index)) {
        // 이미 선택된 경우 선택 취소
        selectedPlaces.remove(index);
      } else {
        // 선택되지 않은 경우 선택 추가
        selectedPlaces.add(index);
      }
    });
  }

  // ### 서버에서 여행 데이터를 받아오는 함수 ###
  Future<List<Map<String, String>>> fetchTravelData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/mytrip')); // 서버에서 여행 데이터 요청

    if (response.statusCode == 200) {
      // 서버 응답이 성공적일 때
      List<dynamic> data = json.decode(response.body); // JSON 응답 파싱

      // 응답 데이터를 List<Map<String, String>> 형식으로 변환
      List<Map<String, String>> travelData = data.map((item) {
        return {
          'title': item['title'].toString(), // 명시적으로 String 변환
          'date': item['date'].toString(),
          'imageUrl': item['imageUrl'].toString(),
        };
      }).toList();

      return travelData; // 변환된 데이터 반환
    } else {
      throw Exception('Failed to load travel data'); // 오류 처리
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTravelData().then((data) {
      // 서버에서 데이터를 받은 후 상태 업데이트
      if (mounted) {
        setState(() {
          travelCards = data; // 서버에서 받은 데이터를 저장
          isLoading = false; // 로딩 완료 상태로 변경
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false; // 오류 발생 시 로딩 완료 상태로 변경
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // AppBar 높이 제거
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator()) // 로딩 중일 때 로딩 아이콘 표시
                      : _buildSelectedTravelCard(), // 선택한 여행 카드만 보여줌
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => onCategoryTap('관심장소'), 
                      child: Text(
                        '관심장소', 
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.w700, 
                          color: selectedCategory=='관심장소' ? const Color(0xFF121212) : const Color(0xFF8F8F8F)
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => onCategoryTap('나의일정'), 
                      child: Text(
                        '나의일정', 
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.w700, 
                          color: selectedCategory=='나의일정' ? const Color(0xFF121212) : const Color(0xFF8F8F8F)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: const Color(0xFFF4F4F4), // 구분선 색상
                ),
                const SizedBox(height: 10),
                // ### 구분선 아래 관심장소 이미지 카드 ###
                selectedCategory == '관심장소' ? _buildGridFavoritePlaces() : Container(),
              ],
            ),
          ),
          _buildAddScheduleButton(), // 새로운 일정 추가 버튼
        ],
      ),
    );
  }

  // ### 선택한 여행 카드만 보여주는 위젯 ###
  Widget _buildSelectedTravelCard() {
    // 선택된 인덱스가 여행 카드 리스트를 넘어가면 오류 메시지 표시
    if (widget.index >= travelCards.length) {
      return const Center(child: Text('해당하는 여행 카드가 없습니다.'));
    }

    // 선택된 카드 정보 가져오기
    Map<String, String> selectedCard = travelCards[widget.index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 padding 설정
      child: _buildTravelCard(
        title: selectedCard['title']!,
        date: selectedCard['date']!,
        imageUrl: selectedCard['imageUrl']!,
      ),
    );
  }

  // ### 여행 카드 UI 위젯 ###
  Widget _buildTravelCard({required String title, required String date, required String imageUrl}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 카드 모서리 둥글게
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // 이미지 모서리 둥글게
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 100), // 이미지
            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white), // 제목 텍스트 스타일
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.white), // 날짜 텍스트 스타일
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 관심장소 이미지 카드 UI
  Widget _buildFavoritePlaceCard({required String cate, required String title, required String imageUrl, required bool isSelected}) {
    return GestureDetector(
      onTap: () => onPlaceTap(favoritePlaces.indexWhere((place) => place['title'] == title && place['imageUrl'] == imageUrl)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // 카드 모서리 둥글게
          side: isSelected ? const BorderSide(color: Color(0xFFFFC04B), width: 10) : BorderSide.none, // 선택된 카드에만 테두리 추가
        ),
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // 이미지 모서리 둥글게
          child: Stack(
            children: [
              Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white), // 카테고리 텍스트
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white), // 제목 텍스트
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
            cate: place['cate']!, // 카테고리 추가
            title: place['title']!,
            imageUrl: place['imageUrl']!,
            isSelected: selectedPlaces.contains(index), // 선택된 인덱스에 해당하는 카드에만 테두리 표시
          );
        },
      ),
    );
  }

  // ### 새로운 일정 추가 버튼 UI ###
  Widget _buildAddScheduleButton() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: Center(
        child: ElevatedButton(
          onPressed: () => onCategoryTap('나의일정'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), // 버튼 색상
            foregroundColor: const Color(0xFFFFFFFF), // 버튼 텍스트 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 50), // 버튼 크기 설정
            elevation: 0,
          ),
          child: const Text(
            '새로운 일정 추가', // 버튼 텍스트
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
