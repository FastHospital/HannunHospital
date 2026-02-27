import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomeLikeScreen(),
    );
  }
}

class HomeLikeScreen extends StatelessWidget {
  const HomeLikeScreen({super.key});
  static const Color kBlue = Color(0xFF2F8CFF);
  static const Color kBlueSoft = Color(0xFFEEF6FF);
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 38),
                  Text(
                    "안녕하세요",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "어디가 아프세요?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: kBlue,
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    height: 110,
                    width: 150,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 192,
                          width: 192,
                          decoration: BoxDecoration(
                            color: kBlueSoft,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Image.asset("images/image.png"),
                        /* Icon(
                          Icons.accessibility_new_rounded,
                          size: 64,
                          color: kBlue.withOpacity(0.9),
                        ),*/
                        Positioned(
                          right: 10,
                          bottom: 20,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xFFDFF5DD),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 16,
                              color: Color(0xFF3CB371),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  _InputPill(
                    hintText: "아프신 증상을 자세히 써주세요",
                    onMicTap: () {},
                    onSendTap: () {},
                  ),
                  SizedBox(height: 86),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        spacing: 18,
                        runSpacing: 18,
                        children: const [
                          _ActionTile(label: "증상보기"),
                          _ActionTile(label: "전체보기"),
                          _ActionTile(label: "병원찾기"),
                          _ActionTile(label: "내 병원"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: w < 360 ? 6 : 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputPill extends StatelessWidget {
  final String hintText;
  final VoidCallback onMicTap;
  final VoidCallback onSendTap;

  const _InputPill({
    required this.hintText,
    required this.onMicTap,
    required this.onSendTap,
  });

  static const Color kBlue = Color(0xFF2F8CFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMicTap,
            icon: Icon(
              Icons.mic_rounded,
              color: Colors.grey.shade600,
            ),
            splashRadius: 22,
            tooltip: "음성 입력",
          ),
          Expanded(
            child: Text(
              hintText,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: onSendTap,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: kBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;

  const _ActionTile({required this.label});

  static const Color kBlue = Color(0xFF2F8CFF);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 92,
      child: Material(
        color: kBlue,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(18),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
