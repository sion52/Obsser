import 'package:flutter/material.dart';

class HashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 50, 38, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildKeywordHeader(),
              SizedBox(height: 8,),
              buildKeywordChips(),
              SizedBox(height: 40,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '교통수단별',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
                    ),
                    TextSpan(
                      text: ' 여행코스',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              buildTransportOptions(),
              SizedBox(height: 40,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '카테고리별',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
                    ),
                    TextSpan(
                      text: ' 여행지',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeywordHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0,0,16,0),
          width: 150,
          height: 25,
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
                icon: Icon(Icons.search, size: 25, color: Color(0xFF000000),),
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

  Widget buildKeywordChips() {
  List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브",];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Container(
      height: 183, // 적절한 높이 설정
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
        padding: EdgeInsets.fromLTRB(8,14,8,0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3개의 열
          childAspectRatio: 1.9, // 버튼 비율
        ),
        itemCount: keywords.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,15),
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 동작
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${keywords[index]} 클릭됨')),
                );
              },
              child: Text(
                keywords[index],
                style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
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

  Widget buildTransportOptions() {
    List<Map<String, dynamic>> transportOptions= [
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
            Container(
              width: 60, // 원의 너비
              height: 60, // 원의 높이
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8E9F1), // 배경색
              ),
              child: Center(
                child: Icon(option['icon'], size: 40, color: Color(0xFF284029),), // 아이콘 크기 조절
              ),
            ),
            SizedBox(height: 3),
            Text(option['label'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
          ],
        );
      }).toList(),
    );
  }

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
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.fromLTRB(14,4,16,4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFE8E9F1),
            image: DecorationImage(
              image: AssetImage(category['image']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            category['label']!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        );
      }).toList(),
    );
  }
}
