import 'package:flutter/material.dart';

class StrokePredictionScreen extends StatefulWidget {
  const StrokePredictionScreen({super.key});

  @override
  State<StrokePredictionScreen> createState() => _StrokePredictionScreenState();
}

class _StrokePredictionScreenState extends State<StrokePredictionScreen> {
 
  DateTime selectedDate = DateTime(1980, 1, 1);
  double age = 44.0; 

  double bmi = 34.0;
  double glucose = 225.0;

  String gender = '남성';
  String residenceType = '도시';
  String heartDisease = '없음';
  String hypertension = '없음';
  String everMarried = '예';
  String workType = '민간';
  String smokingStatus = '흡연';

  String resultText = '데이터를 입력해주세요';
  bool isDark = false;

  final List<String> workTypes = ['민간', '자영업', '공무원', '아동', '무직'];
  final List<String> smokingOptions = ['비흡연', '흡연'];


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: isDark ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // 단순 연도 계산 (필요시 만나이 로직으로 정교화 가능)
        age = (DateTime.now().year - picked.year).toDouble();
      });
    }
  }

  Future<void> predictStroke() async {
    setState(() {
      resultText = '뇌졸중 가능성 있음 (나이: ${age.toInt()}세 기준)';
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
        title: Text('뇌졸중 예측', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => setState(() => isDark = !isDark),
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: textColor),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
          
            _datePickerSection(
              label: '생년월일',
              selectedDate: selectedDate,
              age: age,
              textColor: textColor,
              dividerColor: lineColor,
              onTap: () => _selectDate(context),
            ),

            _sliderSection(
              label: 'BMI',
              valueText: bmi.toStringAsFixed(1),
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
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: predictStroke,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('뇌졸중 예측하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: lineColor),
              ),
              child: Text(
                '예측 결과: $resultText',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }


  Widget _datePickerSection({
    required String label,
    required DateTime selectedDate,
    required double age,
    required Color textColor,
    required Color dividerColor,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    label,
                    style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} (${age.toInt()}세)",
                    style: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                ),
                Icon(Icons.calendar_today, size: 20, color: textColor.withOpacity(0.6)),
              ],
            ),
          ),
        ),
        Divider(color: dividerColor, thickness: 1, height: 22),
      ],
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
              child: Text(label, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              flex: 2,
              child: Text(valueText, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              flex: 5,
              child: Slider(
                value: value,
                min: min,
                max: max,
                activeColor: activeColor,
                onChanged: onChanged,
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
              width: 100,
              child: Text(label, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.end,
                children: options.map((item) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<T>(
                        value: item,
                        groupValue: groupValue,
                        activeColor: activeColor,
                        onChanged: onChanged,
                      ),
                      Text('$item', style: TextStyle(color: textColor, fontSize: 16)),
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
              child: Text(label, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: value,
                dropdownColor: cardColor,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w600),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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