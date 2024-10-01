import 'package:flutter/material.dart';
import 'package:obsser_1/texts/magazine_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

/* ##### 매거진 상세 페이지 ##### */
class MagzScreen extends StatefulWidget {
  final int index; // 매거진 인덱스 전달

  const MagzScreen({super.key, required this.index});

  @override
  State<MagzScreen> createState() => _MagzScreenState();
}

class _MagzScreenState extends State<MagzScreen> {
  bool isFavorite = false; // 즐겨찾기 상태 관리

  // 매거진 이미지 URL 리스트
  final List<String> imageUrl = [
    'assets/magazines/m_0d.png',
    'assets/magazines/m_1d.png',
    'assets/magazines/m_2d.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
        toolbarHeight: 0, // 툴바 높이 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* ### 이미지 및 즐겨찾기 버튼 ### */
            Stack(
              children: [
                // 매거진 이미지 표시
                Image.asset(
                  imageUrl[widget.index], 
                  fit: BoxFit.cover, 
                  width: double.infinity,
                ),
                // 즐겨찾기 아이콘
                // Positioned(
                //   top: 25,
                //   right: 25,
                //   child: GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         isFavorite = !isFavorite; // 즐겨찾기 상태 토글
                //       });
                //     },
                //     child: SvgPicture.asset(
                //       width: 30,
                //       isFavorite ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                //       colorFilter: ColorFilter.mode(
                //         isFavorite ? const Color(0xFFFF5555) : const Color(0xFF000000), // 즐겨찾기 상태에 따른 색상
                //         BlendMode.srcIn,
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            /* ### 매거진 콘텐츠 ### */
            buildContent(widget.index), // 매거진 내용 생성
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /* ### 매거진 내용 생성 함수 ### */
  Widget buildContent(int index) {
    // 매거진 인덱스에 따라 다른 콘텐츠를 반환
    switch (index) {
      case 0:
        return Column(
          children: [
            buildText(t_0_0), // 각 텍스트와 제목을 매거진 콘텐츠로 표시
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
        return Container(); // 기본 값: 빈 컨테이너 반환
    }
  }

  /* ### 제목 스타일 위젯 ### */
  Widget buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // 패딩 설정
      child: Align(
        alignment: Alignment.centerLeft, // 왼쪽 정렬
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /* ### 내용 텍스트 스타일 위젯 ### */
  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), // 패딩 설정
      child: Align(
        alignment: Alignment.centerLeft, // 왼쪽 정렬
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
