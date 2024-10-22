import 'dart:async';
import 'dart:convert';
import 'dart:typed_data'; // Base64 디코딩을 위해 필요
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obsser_1/screens/dol/dol_detail.dart';
import 'package:obsser_1/screens/dol/magazine_detail.dart';
import 'package:obsser_1/screens/dol/magazine_detail_auto.dart';
import 'package:obsser_1/screens/dol/new_post.dart';
import 'package:obsser_1/screens/dol/post.dart';
import 'package:obsser_1/screens/menu/notice.dart';
import 'package:obsser_1/screens/search_screen.dart';

/* ##### 메인 홈 페이지 ##### */
class DolScreen extends StatefulWidget {
  const DolScreen({super.key});

  @override
  State<DolScreen> createState() => _DolScreenState();
}

class _DolScreenState extends State<DolScreen> {
  String dolMessage = 'Loading...'; // 서버 응답 메시지 저장 변수
  List<Map<String, String>> serverData = []; // 서버에서 받아온 데이터를 저장할 리스트
  late PageController _imagePageController; // 이미지 슬라이드용 페이지 컨트롤러
  late PageController _postPageController;  // 게시판용 페이지 컨트롤러
  int _currentSlide = 0; // 현재 슬라이드 인덱스 저장 변수
  Timer? _timer; // 자동 슬라이드를 위한 타이머
  bool isLoading = true; // 로딩 상태 표시
  final TextEditingController _searchController = TextEditingController(); // 검색창 컨트롤러 추가
  

  final List<String> images = [ // 슬라이드 이미지 리스트
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  final List<Map<String, String>> posts = [
    {
      'imageUrl': 'assets/pictures/ex1.png',
    },
    {
      'imageUrl': 'assets/pictures/ex2.png',
    },
    {
      'imageUrl': 'assets/pictures/ex3.png',
    },
  ];

  /* ### 초기화 메서드 ### */
  @override
  void initState() {
    super.initState();

    fetchDolData(); // 페이지 로드 시 서버에서 데이터 요청
    _imagePageController = PageController(); // 이미지 슬라이드용 페이지 컨트롤러 초기화
    _postPageController = PageController();  // 게시판용 페이지 컨트롤러 초기화
    
    // 페이지 변경 시 현재 슬라이드 인덱스 업데이트
    _imagePageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentSlide = _imagePageController.page!.round();
        });
      }
    });

    _startAutoSlide(); // 자동 슬라이드 시작
  }

  /* ### 서버 데이터 요청 메서드 ### */
  Future<void> fetchDolData() async {
    try {
      final response = await http.get(Uri.parse('http://3.37.197.251:5000/')); // 서버에 GET 요청을 보냄

      if (mounted && response.statusCode == 200) { // 서버 응답이 성공적일 경우
        List<dynamic> data = json.decode(response.body)['data']; // 'data' 키 안의 데이터를 파싱
        List<Map<String, String>> parsedData = data.map((item) {
          return {
            'name': item['name'].toString(), // 'name' 값을 String으로 변환하여 저장
            'image': item['image'].toString(), // 'image' 값을 String으로 변환하여 저장
          };
        }).toList();

        setState(() {
          serverData = parsedData; // 서버에서 받아온 데이터를 저장
          isLoading = false; // 로딩 완료
        });
      } else if (mounted) { // 서버 응답 실패 시
        setState(() {
          dolMessage = 'Failed to fetch data. Status code: ${response.statusCode}';
          isLoading = false; // 로딩 완료
        });
      }
    } catch (e) { // 오류 처리
      if (mounted) {
        setState(() {
          dolMessage = 'Error fetching data: $e';
          isLoading = false; // 로딩 완료
        });
      }
    }
  }

  /* ### 리소스 해제 메서드 ### */
  @override
  void dispose() {
    _timer?.cancel(); // 타이머 해제
    _imagePageController.dispose(); // 이미지 슬라이드용 페이지 컨트롤러 해제
    _postPageController.dispose();  // 게시판용 페이지 컨트롤러 해제
    _searchController.dispose(); // 검색창 컨트롤러 해제
    
    super.dispose();
  }

  /* ### 자동 슬라이드 메서드 ### */
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      try {
        if (!mounted) return;

        setState(() {
          _currentSlide = (_currentSlide + 1) % images.length; // 다음 슬라이드로 이동
        });

        _imagePageController.animateToPage(
          _currentSlide,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        print("Error in Timer: $e"); // 오류 로그 출력
      }
    });
  }

  // Base64 문자열을 이미지로 디코딩하는 함수
  Image imageFromBase64String(String base64String) {
    Uint8List imageBytes = base64Decode(base64String);
    return Image.memory(imageBytes, fit: BoxFit.cover);
  }


  /* ### 슬라이드 이미지 클릭 이벤트 처리 ### */
  void _onImageTap(int index) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DolDetail(imageIndex: index,), // 클릭한 슬라이드 인덱스 전달
      )
    );
  }



  /* ### 매거진 이미지 클릭 이벤트 처리 ### */
  void _onMagazineTap(int index) {
    if (index == 2) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => MagzScreenA(), // 인덱스가 2일 때 MagzScreenA로 이동
        ),
      );
    } else {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => MagzScreen(index: index), // 인덱스가 2가 아닐 때는 기존의 MagzScreen으로 이동
        ),
      );
    }
  }


  /* ### 메인 페이지 UI 구성 ### */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // 툴바 높이 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 전체 배경색 설정
      body: SingleChildScrollView( // 페이지 전체를 스크롤 가능하도록 설정
        child: Column(
          children: [
            /* ### 이미지 슬라이드 섹션 ### */
            Stack(
              children: [
                SizedBox( // 슬라이드 이미지 컨테이너
                  height: 470,
                  child: PageView.builder(
                    controller: _imagePageController, // 페이지 컨트롤러 연결
                    itemCount: images.length, // 이미지 개수
                    itemBuilder: (context, index) {
                      return GestureDetector( // 이미지 클릭 이벤트
                        onTap: () => _onImageTap(index), // 클릭 시 상세 페이지로 이동
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover, // 이미지 화면에 맞추기
                        ),
                      );
                    },
                  ),
                ),
                Positioned( // 슬라이드 도트 표시
                  bottom: 3,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // 원형 도트
                          color: _currentSlide == index ? const Color(0xFF85C59A) : const Color(0xFFFFFFFF), // 현재 슬라이드 색상
                        ),
                      );
                    }),
                  ),
                ),
                Positioned( // 알림 아이콘 (오른쪽 상단)
                  top: 25,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.push( // 알림 페이지로 이동
                      context, 
                      MaterialPageRoute(
                        builder: (context) => const NoticeScreen(), // 알림 페이지
                      ),
                    ),
                    // ignore: deprecated_member_use
                    child: SvgPicture.asset('assets/icons/Bell.svg', color: const Color(0xFFFFFFFF), width: 40,), // 알림 아이콘
                  ),
                ),
              ],
            ),

            /* ### 검색 섹션 ### */
            Padding(
              padding: const EdgeInsets.fromLTRB(24,24,24,16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 15, 16, 0),
                      child: Text(
                        '어떤 여행지를 찾으시나요?', // 질문 텍스트
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextField(
                          controller: _searchController, // 검색창 컨트롤러 연결
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: ' 검색',
                            hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF8F9098)),
                            prefixIcon: Icon(Icons.search, color: Color(0xFF000000)),
                          ),
                          onSubmitted: (query) {
                            // 검색어를 입력하고 엔터를 눌렀을 때
                            if (query.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(query: query), // 검색어를 SearchScreen으로 전달
                                ),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => My(), // 검색어를 SearchScreen으로 전달
                              //   ),
                              // );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* ### 게시판 섹션 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '  게시판',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUploadScreen(),
                    ),
                  ),
                  child: const Text(
                    '내 장소 공유하기',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF727272)),
                  ),
                ),
              ],
            ),
          ),

          /* ### 게시판 슬라이드 섹션 ### */
          Stack(
            children: [
              Image.asset('assets/film.png'), // 배경 이미지
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 227, // 슬라이드 게시판 높이 설정
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // 수평 스크롤 설정
                      itemCount: serverData.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: serverData[index], index: index); // PostCard 사용
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),


            const SizedBox(height: 30,),

            /* ### 매거진 섹션 ### */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 1070,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1EA),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 18, 0, 0),
                      child: Text(
                        ' 옵써의 트렌디한 매거진',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        )
                      ),
                    ),
                    _buildMagazineCard(0, 'assets/magazines/m_0.png'), // 첫 번째 매거진 카드
                    _buildMagazineCard(1, 'assets/magazines/m_1.png'), // 두 번째 매거진 카드
                    _buildMagazineCard(2, 'assets/magazines/m_2.png'), // 세 번째 매거진 카드
                  ],
                ),
              ),
            ),

            /* 화면 아래 여백 */
            const SizedBox(height: 25,),

            /* 서버 요청 응답 메시지 */
            // Center(
            //   child: Text(
            //     dolMessage,
            //     style: const TextStyle(fontSize: 12, color: Color(0xFFE0E0E0)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  /* ### 매거진 카드 생성 메서드 ### */
  Widget _buildMagazineCard(int index, String imagePath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: GestureDetector(
        onTap: () => _onMagazineTap(index), // 매거진 클릭 이벤트
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath), // 매거진 이미지 경로
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Map<String, String> post;
  final int index;

  const PostCard({required this.post, required this.index, Key? key}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAlive 사용 시 꼭 호출
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0), // 양쪽 패딩 추가
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(name: widget.post['name']!), // name 값을 전달
            ),
          );
        },
        child: Container(
          width: 263, // 카드 너비 설정
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.memory(
                  base64Decode(widget.post['image']!), // Base64로 디코딩한 이미지
                  fit: BoxFit.cover, // 이미지를 카드 안에 꽉 채우도록 설정
                  width: double.infinity, // 가로 길이를 카드에 맞춤
                  height: 227, // 높이 설정
                ),
              ),
              Positioned(
                bottom: 10, // 텍스트가 이미지 하단에 위치하도록 설정
                left: 10,  // 텍스트가 이미지 왼쪽에 위치하도록 설정
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // 텍스트 배경에 반투명한 검은색 배경 추가
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    widget.post['name']!, // 이미지에 겹쳐서 표시할 이름
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white, // 텍스트를 흰색으로 설정
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // AutomaticKeepAlive를 항상 활성화
}
