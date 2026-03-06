import 'package:flutter/material.dart';

class StrokePredictionScreen extends StatefulWidget {
  const StrokePredictionScreen({super.key});

  @override
  State<StrokePredictionScreen> createState() => _StrokePredictionScreenState();
}

class _StrokePredictionScreenState extends State<StrokePredictionScreen> {
  double age = 70.83;
  double bmi = 34.0;
  double glucose = 225.0;

  String gender = '남성';
  String residenceType = '도시';
  String heartDisease = '없음';
  String hypertension = '없음';
  String everMarried = '예';
  String workType = '민간';
  String smokingStatus = '흡연';

  String resultText = '뇌졸중 가능성 있음';
  bool isDark = false;

  final List<String> workTypes = [
    '민간',
    '자영업',
    '공무원',
    '아동',
    '무직',
  ];

  final List<String> smokingOptions = [
    '비흡연',
    '과거 흡연',
    '흡연',
    '알 수 없음',
  ];

  Future<void> predictStroke() async {
    setState(() {
      resultText = '뇌졸중 가능성 있음';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF111118) : const Color(0xFFF8FAFD);
    final cardColor = isDark ? const Color(0xFF171720) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final accent = const Color(0xFF4A90E2);
    final lineColor = isDark ? Colors.white12 : const Color(0xFFE0E6ED);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          '뇌졸중 예측 앱',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: textColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            _sliderSection(
              label: '나이',
              valueText: age.toStringAsFixed(2),
              value: age,
              min: 0,
              max: 100,
              activeColor: accent,
              textColor: textColor,
              dividerColor: lineColor,
              onChanged: (v) => setState(() => age = v),
            ),
            _sliderSection(
              label: 'BMI',
              valueText: bmi.toStringAsFixed(2),
              value: bmi,
              min: 10,
              max: 60,
              activeColor: accent,
              textColor: textColor,
              dividerColor: lineColor,
              onChanged: (v) => setState(() => bmi = v),
            ),
            _sliderSection(
              label: '혈당 수치',
              valueText: glucose.toStringAsFixed(0),
              value: glucose,
              min: 50,
              max: 300,
              activeColor: accent,
              textColor: textColor,
              dividerColor: lineColor,
              onChanged: (v) => setState(() => glucose = v),
            ),
            _radioSection<String>(
              label: '성별',
              groupValue: gender,
              options: const ['남성', '여성'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => gender = v!),
            ),
            _radioSection<String>(
              label: '거주 형태',
              groupValue: residenceType,
              options: const ['도시', '시골'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => residenceType = v!),
            ),
            _radioSection<String>(
              label: '심장 질환',
              groupValue: heartDisease,
              options: const ['없음', '있음'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => heartDisease = v!),
            ),
            _radioSection<String>(
              label: '고혈압',
              groupValue: hypertension,
              options: const ['없음', '있음'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => hypertension = v!),
            ),
            _radioSection<String>(
              label: '기혼 여부',
              groupValue: everMarried,
              options: const ['아니오', '예'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => everMarried = v!),
            ),
            _dropdownSection(
              label: '직업 유형',
              value: workType,
              items: workTypes,
              textColor: textColor,
              dividerColor: lineColor,
              cardColor: cardColor,
              onChanged: (v) => setState(() => workType = v!),
            ),
            _dropdownSection(
              label: '흡연 상태',
              value: smokingStatus,
              items: smokingOptions,
              textColor: textColor,
              dividerColor: lineColor,
              cardColor: cardColor,
              onChanged: (v) => setState(() => smokingStatus = v!),
            ),
            const SizedBox(height: 28),
            Center(
              child: SizedBox(
                width: 220,
                height: 56,
                child: ElevatedButton(
                  onPressed: predictStroke,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '뇌졸중 예측하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              '예측 결과: $resultText',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sliderSection({
    required String label,
    required String valueText,
    required double value,
    required double min,
    required double max,
    required Color activeColor,
    required Color textColor,
    required Color dividerColor,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                '$label:',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                valueText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: activeColor,
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: activeColor,
                  overlayColor: activeColor.withValues(alpha: 0.15),
                  trackHeight: 6,
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
        Divider(color: dividerColor, thickness: 1, height: 22),
      ],
    );
  }

  Widget _radioSection<T>({
    required String label,
    required T groupValue,
    required List<T> options,
    required Color textColor,
    required Color dividerColor,
    required Color activeColor,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 150,
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10,
                runSpacing: 8,
                children: options.map((item) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<T>(
                        value: item,
                        groupValue: groupValue,
                        activeColor: activeColor,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return activeColor;
                          }
                          return Colors.grey;
                        }),
                        onChanged: onChanged,
                      ),
                      Text(
                        '$item',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Divider(color: dividerColor, thickness: 1, height: 22),
      ],
    );
  }

  Widget _dropdownSection({
    required String label,
    required String value,
    required List<String> items,
    required Color textColor,
    required Color dividerColor,
    required Color cardColor,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 150,
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: value,
                dropdownColor: cardColor,
                iconEnabledColor: textColor,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: dividerColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: dividerColor),
                  ),
                ),
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                items: items.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        Divider(color: dividerColor, thickness: 1, height: 22),
      ],
    );
  }
}