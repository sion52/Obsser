import 'package:flutter/material.dart';

class HashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 50, 28, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '키워드별 여행지',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8,),
              buildKeywordChips(),
              SizedBox(height: 16,),
              Text(
                '교통수단별 여행코스',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8,),
              buildTransportOptions(),
              SizedBox(height: 16,),
              Text(
                '카테고리별 여행지',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8,),
              buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeywordChips() {
  List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브",];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Container(
      height: 200, // 적절한 높이 설정
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
        padding: EdgeInsets.fromLTRB(5,10,5,0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3개의 열
          childAspectRatio: 2, // 버튼 비율
        ),
        itemCount: keywords.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,10),
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 동작
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${keywords[index]} 클릭됨')),
                );
              },
              child: Text(
                keywords[index],
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                backgroundColor: Color(0xFFE8F1EA), // 버튼 배경색
                foregroundColor: Color(0xFF000000), // 버튼 텍스트 색
              ),
            ),
          );
        },
      ),
    ),
  );
}

  Widget buildTransportOptions() {
    List<Map<String, dynamic>> trasnportOptions= [
      {'icon': Icons.directions_car, 'label': '자동차'},
      {'icon': Icons.pedal_bike, 'label': '자전거'},
      {'icon': Icons.directions_walk, 'label': '도보'},
      {'icon': Icons.directions_bus, 'label': '버스'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: trasnportOptions.map((option) {
        return Column(
          children: [
            Icon(option['icon'], size: 40,),
            SizedBox(height: 8,),
            Text(option['label']),
          ],
        );
      }).toList(),
    );
  }

  Widget buildCategoryList() {
    List<String> categories = ['식당', '카페', '명소'];

    return Column(
      children: categories.map((category) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            category,
            style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
    );
  }
}
