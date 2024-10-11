import 'package:flutter/material.dart';
import 'package:obsser_1/services/chatgpt_service.dart';

/* ##### 매거진 상세 페이지 ##### */
class MagzScreenA extends StatefulWidget {
  const MagzScreenA({super.key});

  @override
  State<MagzScreenA> createState() => _MagzScreenAState();
}

class _MagzScreenAState extends State<MagzScreenA> {
  bool isFavorite = false; // 즐겨찾기 상태 관리
  final ChatGptService chatGptService = ChatGptService(); // ChatGptService 인스턴스 생성
  String magazineContent = "Loading content..."; // 초기 상태 메시지

  @override
  void initState() {
    super.initState();
    _loadContent(); // 화면이 로드될 때 콘텐츠를 가져옴
  }

  // 콘텐츠를 ChatGPT API를 통해 로드하는 메서드
  Future<void> _loadContent() async {
    String content = await chatGptService.generateJejuMagazineContent(); // ChatGPT API 호출
    setState(() {
      magazineContent = content; // 콘텐츠를 상태로 저장
    });
  }

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
                  'assets/magazines/m_2d.png', 
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
            buildContent(), // 매거진 내용 생성
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /* ### 매거진 내용 생성 함수 ### */
  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        magazineContent, // ChatGPT API에서 받은 콘텐츠를 출력
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
