import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data'; // Base64 이미지 디코딩에 필요

/* ##### 여행 카드 상세보기 화면 ##### */
class TripScreen extends StatefulWidget {
  final int index; // 선택된 카드의 인덱스
  const TripScreen({super.key, required this.index});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<Map<String, String>> travelCards = []; // 서버에서 받아온 여행 카드 데이터를 저장
  bool isLoading = true; // 로딩 상태 변수
  String selectedCategory = "관심장소"; // 선택된 카테고리를 저장하는 변수
  List<int> selectedPlaces = []; // 선택된 관심장소의 인덱스 리스트
  List<Map<String, String>> favoritePlaces = []; // 서버에서 받아온 찜 데이터 저장

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://3.37.197.251:5000/mytrip'),
      headers: {'Authorization': 'Bearer $token'},
    ); // 서버에서 여행 데이터 요청

    if (response.statusCode == 200) {
      // 서버 응답이 성공적일 때
      List<dynamic> data = json.decode(response.body)['data']; // JSON 응답 파싱

      // 응답 데이터를 List<Map<String, String>> 형식으로 변환
      List<Map<String, String>> travelData = data.map((item) {

        String dadate = formatTimestamp(item['date'].toString());

        return {
          'name': item['name'].toString(), // 명시적으로 String 변환
          'date': dadate,
          'image_url': item['image_url'].toString(),
        };
      }).toList();

      return travelData; // 변환된 데이터 반환
    } else {
      throw Exception('Failed to load travel data'); // 오류 처리
    }
  }

  String formatTimestamp(String timestamp) {
    // 시작 날짜와 끝 날짜를 각각 슬라이싱 (첫 8자리와 마지막 8자리)
    String startDate = timestamp.substring(0, 8); // '20241001'
    String endDate = timestamp.substring(8); // '20241008'

    // 슬라이싱된 문자열을 yyyy.mm.dd 형식으로 변환
    String formattedStartDate = '${startDate.substring(0, 4)}.${startDate.substring(4, 6)}.${startDate.substring(6, 8)}';
    String formattedEndDate = '${endDate.substring(0, 4)}.${endDate.substring(4, 6)}.${endDate.substring(6, 8)}';

    // 'yyyy.mm.dd - yyyy.mm.dd' 형식으로 출력
    return '$formattedStartDate - $formattedEndDate';
  }

  // ### 서버에서 관심장소 데이터를 받아오는 함수 ###
  Future<void> fetchPlaceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://3.37.197.251:5000/place_pages/맛집'),
      headers: {'Authorization': 'Bearer $token'},
    ); // 서버에서 관심장소 데이터 요청

    if (response.statusCode == 200) {
      // 서버 응답이 성공적일 때
      List<dynamic> data = json.decode(response.body)['data']; // JSON 응답 파싱

      // 응답 데이터를 List<Map<String, String>> 형식으로 변환
      List<Map<String, String>> favoriteData = data.map((item) {
        return {
          'name': item['name'].toString(), // 명시적으로 String 변환
          'image': item['image'].toString(), // Base64 인코딩된 이미지
        };
      }).toList();

      setState(() {
        favoritePlaces = favoriteData; // 서버에서 받은 관심장소 데이터를 저장
        isLoading = false; // 로딩 완료 상태로 변경
      });
    } else {
      throw Exception('Failed to load place data'); // 오류 처리
    }
  }

  // Base64 문자열을 이미지로 디코딩하는 함수
  Image imageFromBase64String(String base64String) {
    Uint8List imageBytes = base64Decode(base64String); // Base64 디코딩
    return Image.memory(imageBytes, fit: BoxFit.cover); // 이미지로 변환
  }

  @override
  void initState() {
    super.initState();
    fetchTravelData().then((data) {
      // 서버에서 여행 데이터를 받은 후 상태 업데이트
      if (mounted) {
        setState(() {
          travelCards = data; // 서버에서 받은 데이터를 저장
          isLoading = false; // 로딩 완료 상태로 변경
        });
      }
    });

    fetchPlaceData(); // 관심장소 데이터를 불러옴
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
                const SizedBox(height: 8),
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
                          color: selectedCategory == '관심장소'
                              ? const Color(0xFF121212)
                              : const Color(0xFF8F8F8F),
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
                          color: selectedCategory == '나의일정'
                              ? const Color(0xFF121212)
                              : const Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: const Color(0xFFF4F4F4), // 구분선 색상
                ),
                const SizedBox(height: 10),
                // ### 구분선 아래 관심장소 이미지 카드 ###
                selectedCategory == '관심장소'
                    ? _buildGridFavoritePlaces()
                    : Container(),
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
        title: selectedCard['name']!,
        date: selectedCard['date']!,
        imageUrl: selectedCard['image_url']!,
      ),
    );
  }

  // ### 여행 카드 UI 위젯 ###
  Widget _buildTravelCard({
    required String title,
    required String date,
    required String imageUrl,
  }) {
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
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white), // 제목 텍스트 스타일
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white), // 날짜 텍스트 스타일
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
  Widget _buildFavoritePlaceCard({
    required String title,
    required String base64Image,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () =>
          onPlaceTap(favoritePlaces.indexWhere((place) => place['name'] == title)),
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
              Positioned.fill( // 부모 컨테이너 크기에 맞춰 이미지를 채움
                child: imageFromBase64String(base64Image), // Base64 이미지 디코딩 후 표시
              ),
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
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
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
            title: place['name']!,
            base64Image: place['image']!,
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
            minimumSize: const Size(300, 50), // 버튼 크기 설정
            elevation: 0,
          ),
          child: const Text(
            '선택한 관심장소로 일정짜기', // 버튼 텍스트
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
