import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/* ##### 공지사항 화면 ##### */
class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late GoogleMapController mapController;
  
  final LatLng _center = const LatLng(33.3793324,126.5462801);
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController에 query 값을 설정
    final TextEditingController searchController = TextEditingController(text: widget.query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // 툴바 높이 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        children: [
          /* ### 상단 네비게이션 바 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0), // 패딩 설정
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
          const SizedBox(height: 20,),
          /* ### 구글맵 위젯 ### */
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
