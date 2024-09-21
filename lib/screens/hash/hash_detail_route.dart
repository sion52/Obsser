import 'package:flutter/material.dart';

class HashDetailRoute extends StatefulWidget {
  final String selectedKeyword;

  const HashDetailRoute({super.key, required this.selectedKeyword,});

  @override
  // ignore: library_private_types_in_public_api
  _HashDetailRouteState createState() => _HashDetailRouteState();
}

class _HashDetailRouteState extends State<HashDetailRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(  // SingleChildScrollView를 Column 바깥으로 배치
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, widget.selectedKeyword);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Color(0xFF000000),
                        ),
                      ),
                      buildKeywordHeader(),
                    ],
                  ),
                  const SizedBox(height: 35,),
                  Column(  // Column을 SingleChildScrollView 안쪽에 둠
                    children: [
                      buildCard('삼성혈', 'assets/pictures/samsung.png', '제주 제주시 삼성로 22', """제주 시내에 위치해 있어 여행의 시작점으로 좋습니다.\n이곳에서 제주도의 역사와 문화를 간단히 알아보세요."""),  
                      buildtime(30),
                      buildCard('카멜리아힐', 'assets/pictures/camellia.png', '제주 서귀포시 안덕면 병악로 166', "아름다운 차밭과 꽃들이 있는 곳이니 여유롭게 구경하세요."),
                      buildtime(15),
                      buildCard('생각하는 정원', 'assets/pictures/garden.png', '제주 제주시 한경면 녹차분재로 675', "다양한 식물과 예쁜 경관을 즐길 수 있는 곳입니다."),
                      buildtime(20),
                      buildCard('베케', 'assets/pictures/veke.png', '제주 서귀포시 효돈로 48', "이곳에서 제주 베케의 아름다움을 만끽하세요."),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKeywordHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 가로, 세로 패딩 설정
      decoration: BoxDecoration(
        color: const Color(0xFF497F5B),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        '옵써가 계획한 ${widget.selectedKeyword} 여행루트예요.',
        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
      ),
    );
  }

  Widget buildCard(String title, String image, String location, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10,),
        Center( // Center를 사용하여 ClipRRect를 가운데 정렬
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // 이미지 모서리를 둥글게
            child: Image.asset(
              image, // 여기에 이미지 경로 추가
              width: 250, // 이미지 가로 크기
              height: 190, // 이미지 세로 크기
              fit: BoxFit.cover, // 이미지가 컨테이너 크기에 맞게
            ),
          ),
        ),
        const SizedBox(height: 8,),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFF000000),),
              Text(location, style: const TextStyle(fontSize: 17),)
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Center(
          child: Text(text, style: const TextStyle(fontSize: 13),),
        )
      ],
    );
  }

  Widget buildtime(int time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          const Positioned(left: 15, child: Icon(Icons.more_vert, color: Color(0xFF000000),),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('소요시간 $time분', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),)
            ],
          )
        ],
      ),
    );
  }
}
