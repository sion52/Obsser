import 'package:flutter/material.dart';
import 'package:obsser_1/texts/magazine_text.dart';

class MagzScreen extends StatefulWidget {
  final int index;

  MagzScreen({required this.index}); // 인덱스 전달 받음

  @override
  _MagzScreenState createState() => _MagzScreenState();
}

class _MagzScreenState extends State<MagzScreen> {
  bool isFavorite = false;

  // 이미지 목록
  final List<String> imageUrl = [
    'assets/magazines/m_0d.png',
    'assets/magazines/m_1d.png',
    'assets/magazines/m_2d.png',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 0,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(imageUrl[widget.index], fit: BoxFit.cover, width: double.infinity,),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite; // 해당 카드의 즐겨찾기 상태만 변경
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            buildContent(widget.index),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

  Widget buildContent(int index) {
    switch (widget.index) {
      case 0:
        return Column(
          children: [
            buildText(t_0_0),
            buildTitle('1. 협재 해수욕장'),
            buildText(t_0_1),
            buildTitle('2. 함덕 해수욕장'),
            buildText(t_0_2),
            buildTitle('3. 용머리 해안'),
            buildText(t_0_3),
            buildTitle('4. 중문 색달 해변'),
            buildText(t_0_4),
            buildTitle('5. 이호테우해변'),
            buildText(t_0_5),
            buildTitle('해수욕장에서 즐길 수 있는 액티비티'),
            buildText(t_0_6),
            buildTitle('여행 팁 및 주의사항'),
            buildText(t_0_7),
            buildTitle('#해수욕장 #여름휴가 #여행추천 #바️️️다🏝'),
          ],
        );
      case 1:
        return Column(
          children: [
            buildText(t_1_0),
            buildText(t_1_1),
            buildTitle('친환경 숙소 소개'),
            buildText(t_1_2),
            buildTitle('제주도에서 즐길 수 있는 친환경 활동'),
            buildText(t_1_3),
            buildTitle('제주도의 에코 투어리즘 명소'),
            buildText(t_1_4),
            buildTitle('지속 가능한 여행을 위한 팁과 주의사항'),
            buildText(t_1_5),
            buildText(t_1_6),
            buildText(t_1_7),
            buildTitle('#제주도 #친환경여행 #지속가능한여행 #에코투어리즘 #친환경숙소'),
          ],
        );
      case 2:
        return Column(
          children: [
            buildText(t_2_0),
            buildText(t_2_1),
            buildTitle('전통 시장 탐방'),
            buildText(t_2_2),
            buildTitle('공예 체험 활동'),
            buildText(t_2_3),
            buildTitle('민속촌 방문'),
            buildText(t_2_4),
            buildTitle('가족과 함께하는 문화 체험 추천'),
            buildText(t_2_5),
            buildTitle('제주 문화 체험을 위한 팁'),
            buildText(t_2_6),
            buildText(t_2_7),
            buildText(t_2_8),
            buildTitle('#제주문화체험 #전통시장 #공예체험 #민속촌 #가족여행 #여행팁'),
          ],
        );
      default:
        return Container();
    }
  }

  Widget buildTitle(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      )
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      )
    );
  }
}
