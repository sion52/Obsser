import 'package:flutter/gestures.dart';
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
  List<String> selectedPlaceNames = []; // 선택된 장소의 이름 리스트

  void onCategoryTap(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void onPlaceTap(int index) {
    setState(() {
      if (selectedPlaces.contains(index)) {
        selectedPlaces.remove(index);
        selectedPlaceNames.remove(favoritePlaces[index]['name']);
      } else {
        selectedPlaces.add(index);
        selectedPlaceNames.add(favoritePlaces[index]['name']!);
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
      List<dynamic> data = json.decode(response.body)['data']; // JSON 응답 파싱
      List<Map<String, String>> travelData = data.map((item) {
        String dadate = formatTimestamp(item['date'].toString());
        return {
          'name': item['name'].toString(),
          'date': dadate,
          'image_url': item['image_url'].toString(),
        };
      }).toList();
      return travelData;
    } else {
      throw Exception('Failed to load travel data');
    }
  }

  String formatTimestamp(String timestamp) {
    String startDate = timestamp.substring(0, 8);
    String endDate = timestamp.substring(8);
    String formattedStartDate =
        '${startDate.substring(0, 4)}.${startDate.substring(4, 6)}.${startDate.substring(6, 8)}';
    String formattedEndDate =
        '${endDate.substring(0, 4)}.${endDate.substring(4, 6)}.${endDate.substring(6, 8)}';
    return '$formattedStartDate - $formattedEndDate';
  }

  // ### 서버에서 관심장소 데이터를 받아오는 함수 ###
  Future<void> fetchPlaceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://3.37.197.251:5000/mytrip/myplace'),
      headers: {'Authorization': 'Bearer $token'},
    ); // 서버에서 관심장소 데이터 요청

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data']; // JSON 응답 파싱
      List<Map<String, String>> favoriteData = data.map((item) {
        return {
          'name': item['name'].toString(),
          'image': item['image'].toString(),
        };
      }).toList();

      setState(() {
        favoritePlaces = favoriteData;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load place data');
    }
  }

  // Base64 문자열을 이미지로 디코딩하는 함수
  Image imageFromBase64String(String base64String) {
    Uint8List imageBytes = base64Decode(base64String);
    return Image.memory(imageBytes, fit: BoxFit.cover);
  }

  @override
  void initState() {
    super.initState();
    fetchTravelData().then((data) {
      if (mounted) {
        setState(() {
          travelCards = data;
          isLoading = false;
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
        toolbarHeight: 0,
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
                      ? const Center(child: CircularProgressIndicator())
                      : _buildSelectedTravelCard(),
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
                  color: const Color(0xFFF4F4F4),
                ),
                const SizedBox(height: 10),
                selectedCategory == '관심장소'
                    ? _buildGridFavoritePlaces()
                    : _plan(), // 선택한 카테고리에 따라 일정 표시
              ],
            ),
          ),
          _buildAddScheduleButton(),
        ],
      ),
    );
  }

  // ### 선택한 여행 카드만 보여주는 위젯 ###
  Widget _buildSelectedTravelCard() {
    if (widget.index >= travelCards.length) {
      return const Center(child: Text('해당하는 여행 카드가 없습니다.'));
    }
    Map<String, String> selectedCard = travelCards[widget.index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 100),
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
                        color: Colors.white),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
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
          borderRadius: BorderRadius.circular(15),
          side: isSelected
              ? const BorderSide(color: Color(0xFFFFC04B), width: 10)
              : BorderSide.none,
        ),
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: imageFromBase64String(base64Image),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                alignment: Alignment.bottomLeft,
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: favoritePlaces.length,
        itemBuilder: (context, index) {
          final place = favoritePlaces[index];
          return _buildFavoritePlaceCard(
            title: place['name']!,
            base64Image: place['image']!,
            isSelected: selectedPlaces.contains(index),
          );
        },
      ),
    );
  }

  // 일정 드래그 가능한 리스트
  Widget _plan() {
    return Expanded(
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        dragStartBehavior: DragStartBehavior.down, // 드래그를 빠르게 시작할 수 있도록 설정
        children: List.generate(
          selectedPlaceNames.length,
          (index) {
            return Padding(
              key: ValueKey(selectedPlaceNames[index]),
              padding: const EdgeInsets.symmetric(vertical: 10), // 리스트 항목 사이 여백 추가
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100), // 애니메이션 효과 추가
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // 회색 배경색
                  borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4, // 그림자 효과
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    selectedPlaceNames[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.drag_handle), // 드래그 핸들 아이콘 추가
                ),
              ),
            );
          },
        ),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = selectedPlaceNames.removeAt(oldIndex);
            selectedPlaceNames.insert(newIndex, item);
          });
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
            backgroundColor: const Color(0xFFFFC04B),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(300, 50),
            elevation: 0,
          ),
          child: const Text(
            '선택한 관심장소로 일정짜기',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
