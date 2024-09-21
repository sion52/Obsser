import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obsser_1/screens/hash/hash_detail_route.dart';

class HashDetail extends StatefulWidget {
  final Function(int) onKeywordSelected;
  final String selectedKeyword;

  const HashDetail({super.key, required this.selectedKeyword, required this.onKeywordSelected, });

  @override
  // ignore: library_private_types_in_public_api
  _HashDetailState createState() => _HashDetailState();
}
class _HashDetailState extends State<HashDetail> {
  List<bool> isFavoriteList = [false, false, false, false]; // 각 카드의 즐겨찾기 상태를 저장하는 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 16),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildKeywordHeader(),
                  const SizedBox(height: 8,),
                  buildKeywordChips(),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '옵써가 계획한 ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Text(
                    widget.selectedKeyword,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF497F5B),
                    ),
                  ),
                  const Text(
                    ' 여행루트는 어때요? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => HashDetailRoute(selectedKeyword: widget.selectedKeyword,)),
                      );
                    },
                    child: const Text(
                      '보러가기>',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildKeywordChips() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 660,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: const Color(0xA6A4A4A4),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // 버튼 클릭 시 동작
                        Navigator.pop(context, widget.selectedKeyword);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: const Color(0xFFD9D9D9), // 버튼 배경색
                        foregroundColor: const Color(0xFF000000), // 버튼 텍스트 색
                        elevation: 0, // 그림자 제거
                        minimumSize: const Size(110, 50),
                      ),
                      child: Text(
                        widget.selectedKeyword,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildCard(0, '카멜리아 힐', 'assets/pictures/camellia.png'),
                          const SizedBox(height: 5,),
                          _buildCard(1, '생각하는 정원', 'assets/pictures/garden.png'),
                          const SizedBox(height: 5,),
                          _buildCard(2, '베케', 'assets/pictures/veke.png'),
                          const SizedBox(height: 5,),
                          _buildCard(3, '삼성혈', 'assets/pictures/samsung.png'),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter, // 가로 가운데, 세로는 아래
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0), // 아래로부터 15의 간격
                child: SvgPicture.asset('assets/icons/Down.svg'),
              ),
            ),
          ],
        )
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
              child: Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
            Positioned(
              bottom: 15,
              right: 10,
              child: GestureDetector(
                onTap: () => {
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index]; // 해당 카드의 즐겨찾기 상태만 변경
                  })
                },
                child: SvgPicture.asset(
                  isFavoriteList[index] ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                  colorFilter: ColorFilter.mode(
                    isFavoriteList[index] ? const Color(0xFFFF5555) : const Color(0xFFFFFFFF),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
