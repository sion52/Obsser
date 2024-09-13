import 'package:flutter/material.dart';

class HashScreen extends StatefulWidget {
  final Function(int) onKeywordSelected;

  HashScreen({required this.onKeywordSelected});

  @override
  _HashScreenState createState() => _HashScreenState();
}

class _HashScreenState extends State<HashScreen> {
  String? selectedKeyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 50, 38, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildKeywordHeader(), // 키워드 헤더 위젯
              SizedBox(height: 8,),
              buildKeywordChips(), // 키워드 칩 위젯
              SizedBox(height: 40,),
              buildTransportTitle(), // 교통수단별 여행코스 제목
              SizedBox(height: 10,),
              buildTransportOptions(), // 교통수단 옵션 위젯
              SizedBox(height: 40,),
              buildCategoryTitle(), // 카테고리별 여행지 제목
              SizedBox(height: 16,),
              buildCategoryList(), // 카테고리 리스트 위젯
            ],
          ),
        ),
      ),
    );
  }

  // 키워드별 여행지 헤더
  Widget buildKeywordHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
              ),
            ],
          ),
        ),
        // 검색 입력 필드
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 20, 0),
          width: 155,
          height: 30,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.search, size: 28, color: Color(0xFF000000),),
                onPressed: () {
                  // 검색 버튼 클릭 시 동작
                },
              ),
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 30,
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0), // 수직 패딩 조정
            ),
          ),
        ),
      ],
    );
  }

  // 키워드 칩 리스트
  Widget buildKeywordChips() {
    List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브", ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 185, // 칩 리스트 높이
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF), // 배경색
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          border: Border.all(
            width: 1,
            color: Color(0xA6A4A4A4)
          )
        ),
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(7, 14, 7, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3개의 열
            childAspectRatio: 2, // 버튼 비율
          ),
          itemCount: keywords.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 동작
                  widget.onKeywordSelected(11);
                },
                child: Text(
                  keywords[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Color(0xFFE8F1EA), // 버튼 배경색
                  foregroundColor: Color(0xFF000000), // 버튼 텍스트 색
                  elevation: 0, // 그림자 제거
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 교통수단 옵션 제목
  Widget buildTransportTitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '교통수단별',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF497F5B)),
          ),
          TextSpan(
            text: ' 여행코스',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // 교통수단 옵션 위젯
  Widget buildTransportOptions() {
    List<Map<String, dynamic>> transportOptions = [
      {'icon': Icons.directions_car, 'label': '자동차'},
      {'icon': Icons.pedal_bike, 'label': '자전거'},
      {'icon': Icons.directions_walk, 'label': '도보'},
      {'icon': Icons.directions_bus, 'label': '버스'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: transportOptions.map((option) {
        return Column(
          children: [
            // 아이콘 원형 배경
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8E9F1), // 배경색
              ),
              child: Center(
                child: Icon(option['icon'], size: 40, color: Color(0xFF284029)), // 아이콘
              ),
            ),
            SizedBox(height: 3),
            Text(option['label'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)), // 라벨
          ],
        );
      }).toList(),
    );
  }

  // 카테고리별 여행지 제목
  Widget buildCategoryTitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '카테고리별',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
          ),
          TextSpan(
            text: ' 여행지',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // 카테고리 리스트 위젯
  Widget buildCategoryList() {
    List<Map<String, String>> categories = [
      {'label': '식당', 'image': 'assets/buttons/back_1.png'},
      {'label': '카페', 'image': 'assets/buttons/back_2.png'},
      {'label': '명소', 'image': 'assets/buttons/back_3.png'}
    ];

    return Column(
      children: categories.map((category) {
        return Container(
          width: double.infinity,
          height: 40,
          margin: EdgeInsets.symmetric(vertical: 7),
          padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFE8E9F1),
            image: DecorationImage(
              image: AssetImage(category['image']!), // 카테고리 이미지
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Text(
                  category['label']!, // 카테고리 라벨
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    print('${category['label']} 버튼 클릭됨');
                  }, 
                  icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF000000),size: 20,)),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
