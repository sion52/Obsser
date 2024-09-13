import 'package:flutter/material.dart';

class HashDetail extends StatefulWidget {
  @override
  _HashDetailState createState() => _HashDetailState();
}

class _HashDetailState extends State<HashDetail> {
  List<bool> isFavoriteList = [false, false, false, false]; // 각 카드의 즐겨찾기 상태를 저장하는 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 16),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildKeywordHeader(),
                  SizedBox(height: 8,),
                  buildKeywordChips(),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '옵써가 계획한 ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Text(
                    '#한적한',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF497F5B),
                    ),
                  ),
                  Text(
                    ' 여행루트는 어때요? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(builder: (context) => SignupScreen()),
                      // );
                    },
                    child: Text(
                      '보러가기>',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF497F5B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildKeywordChips() {
    List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브", ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 660,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: Color(0xA6A4A4A4),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 동작
                    // widget.onKeywordSelected(11);
                  },
                  child: Text(
                    keywords[0],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xFFD9D9D9), // 버튼 배경색
                    foregroundColor: Color(0xFF000000), // 버튼 텍스트 색
                    elevation: 0, // 그림자 제거
                    minimumSize: Size(110, 50),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCard(0, '카멜리아 힐', 'assets/pictures/camellia.png'),
                      SizedBox(height: 5,),
                      _buildCard(1, '생각하는 정원', 'assets/pictures/garden.png'),
                      SizedBox(height: 5,),
                      _buildCard(2, '베케', 'assets/pictures/veke.png'),
                      SizedBox(height: 5,),
                      _buildCard(3, '삼성혈', 'assets/pictures/samsung.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index, String title, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 220),
            Positioned(
              bottom: 10,
              left: 15,
              child: Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Positioned(
              bottom: 5,
              right: 2,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index]; // 해당 카드의 즐겨찾기 상태만 변경
                  });
                },
                icon: Icon(
                  isFavoriteList[index] ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
