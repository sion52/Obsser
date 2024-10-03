import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGptService {
  final String apiKey = ''; // OpenAI API 키

  // ChatGPT API 호출 함수
  Future<String> generateJejuMagazineContent() async {
    const String apiUrl = 'https://api.openai.com/v1/chat/completions'; // 엔드포인트 수정

    // 요청에 사용할 헤더
    final headers = {
      'Content-Type': 'application/json; charset=utf-8', // UTF-8로 인코딩
      'Authorization': 'Bearer $apiKey',
    };

    // 요청에 포함할 데이터
    final body = jsonEncode({
      "model": "gpt-3.5-turbo", // GPT-3.5 또는 GPT-4 모델 사용 가능
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant who provides information in Korean."
        },
        {
          "role": "user",
          "content": "제주도 여행 팁에 대한 매거진 기사를 작성해줘." // 한국어로 질문
        }
      ],
      "max_tokens": 1000, // 생성할 텍스트의 최대 토큰 수
    });

    try {
      // API 요청
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        // 응답 본문을 UTF-8로 디코딩
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final content = jsonResponse['choices'][0]['message']['content'];
        return content;
      } else {
        return 'Failed to fetch data: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error fetching data: $e';
    }
  }
}
