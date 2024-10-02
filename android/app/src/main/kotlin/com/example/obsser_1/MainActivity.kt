package com.example.obsser_1

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.kakao.map.sdk.KakaoMapSdk

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        KakaoMapSdk.init(this, "6c85d32531fc66eef97c76fb687d20cf") // 발급받은 카카오 네이티브 앱 키로 교체
    }
}