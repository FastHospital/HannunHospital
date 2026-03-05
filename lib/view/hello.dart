import 'package:flutter/material.dart';
import 'package:mytownmysymptom/theme/app_color.dart';
import 'package:mytownmysymptom/view/symptom.dart';
import '../widgets/action_tile.dart';
import '../widgets/input_pill.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

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
                      color: AppColors.blue,
                    ),
                  ),
                  SizedBox(height: 18),

                  SizedBox(
                    height: 110,
                    width: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 192,
                          width: 192,
                          decoration: const BoxDecoration(
                            color: AppColors.blueSoft,
                            shape: BoxShape.circle,
                          ),
                        ),

                        Image.asset("images/image.png"),
                        Positioned(
                          right: 10,
                          bottom: 20,
                          child: Container(
                            padding: const EdgeInsets.all(
                              6,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.heartBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 16,
                              color: AppColors.heart,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 80),

                  InputPill(
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
                        children: [
                          ActionTile(
                            label: "증상보기",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const SymptomScreen(),
                                ),
                              );
                            },
                          ),
                          ActionTile(
                            label: "전체보기",
                            onTap: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text("준비중이에요!"),
                                ),
                              );
                            },
                          ),
                          ActionTile(
                            label: "병원찾기",
                            onTap: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text("준비중이에요!"),
                                ),
                              );
                            },
                          ),
                          ActionTile(
                            label: "내 병원",
                            onTap: () {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text("준비중이에요!"),
                                ),
                              );
                            },
                          ),
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
