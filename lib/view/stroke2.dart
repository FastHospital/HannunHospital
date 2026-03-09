import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StrokePrediction2Screen extends StatefulWidget {
  const StrokePrediction2Screen({super.key});

  @override
  State<StrokePrediction2Screen> createState() => _StrokePrediction2ScreenState();
}

class _StrokePrediction2ScreenState extends State<StrokePrediction2Screen> {
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

  String resultText = '데이터를 입력해주세요.';
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
      final now = DateTime.now();
      int calculatedAge = now.year - picked.year;
      if (now.month < picked.month ||
          (now.month == picked.month && now.day < picked.day)) {
        calculatedAge--;
      }

      setState(() {
        selectedDate = picked;
        age = calculatedAge.toDouble();
      });
    }
  }

  Future<void> predictStroke() async {
    

    /*
0 - Never_worked, 
1 - children, 
2 - Govt_job, 
3 - Self-employed, 
4 - Private
    */
    var jsonBody = {
      "age": age.toString(),
      "sex": gender == '남성' ? "1": "0",
      "hypertension": hypertension =='있음'?"1":"0",
      "heart_disease": heartDisease == '있음'? "1":"0",
      "ever_married": everMarried == "예"?"1":"0", //everMarried.toString(),
      "work_type": workType=="민간"?"4":workType=="자영업"?"3":workType=='공무원'?"2":workType=='아동'?"1":"0",
      "Residence_type": residenceType == "도시"? "1":"0",
      "avg_glucose_level": glucose.toString(),
      "bmi": bmi.toString(),
      "smoking_status": smokingStatus =="흡연"?"1":"0",
    };
    Map<String,String> xx = {'Content-Type':'application/json'};
    final response = await http.post(Uri.parse('http://172.16.250.187:8000/items/result'), headers:xx,  body: jsonEncode(jsonBody));
    String risk = '낮음';

    final rObj = jsonDecode(response.body);

    if(rObj['result'] == 0  ){
      setState(() {
        resultText = '예측 결과: 아직 안전합니다.';
      });
    }else{
            setState(() {
        resultText = '예측 결과: 위험';
      });
    }

    // int score = 0;
    // if (age >= 60) score += 2;
    // if (bmi >= 30) score += 1;
    // if (glucose >= 180) score += 2;
    // if (heartDisease == '있음') score += 2;
    // if (hypertension == '있음') score += 2;
    // if (smokingStatus == '흡연') score += 1;

    // if (score >= 6) {
    //   risk = '높음';
    // } else if (score >= 3) {
    //   risk = '보통';
    // }

    // setState(() {
    //   resultText = '예측 결과: 뇌졸중 위험도 $risk\n(나이 ${age.toInt()}세 기준)';
    // });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF0F1115) : const Color(0xFFF4F7FB);
    final cardColor = isDark ? const Color(0xFF1A1D24) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final subTextColor =
        isDark ? Colors.white70 : const Color(0xFF6B7280);
    final accent = const Color(0xFF4A90E2);
    final borderColor =
        isDark ? Colors.white10 : const Color(0xFFE5EAF0);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '뇌졸중 예측',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => isDark = !isDark),
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: textColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(
              cardColor: cardColor,
              textColor: textColor,
              subTextColor: subTextColor,
              borderColor: borderColor,
            ),
            const SizedBox(height: 16),

            _sectionCard(
              title: '기본 정보',
              cardColor: cardColor,
              borderColor: borderColor,
              titleColor: textColor,
              child: Column(
                children: [
                  _dateTile(
                    label: '생년월일',
                    value:
                        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                    subValue: '만 ${age.toInt()}세',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),
                  _choiceSection(
                    label: '성별',
                    value: gender,
                    options: const ['남성', '여성'],
                    onChanged: (v) => setState(() => gender = v),
                    textColor: textColor,
                    accent: accent,
                  ),
                  const SizedBox(height: 16),
                  _choiceSection(
                    label: '거주 형태',
                    value: residenceType,
                    options: const ['도시', '시골'],
                    onChanged: (v) => setState(() => residenceType = v),
                    textColor: textColor,
                    accent: accent,
                  ),
                  const SizedBox(height: 16),
                  _choiceSection(
                    label: '기혼 여부',
                    value: everMarried,
                    options: const ['아니오', '예'],
                    onChanged: (v) => setState(() => everMarried = v),
                    textColor: textColor,
                    accent: accent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: '건강 정보',
              cardColor: cardColor,
              borderColor: borderColor,
              titleColor: textColor,
              child: Column(
                children: [
                  _sliderTile(
                    label: 'BMI',
                    value: bmi,
                    min: 10,
                    max: 60,
                    textColor: textColor,
                    accent: accent,
                    onChanged: (v) => setState(() => bmi = v),
                  ),
                  const SizedBox(height: 12),
                  _sliderTile(
                    label: '혈당 수치',
                    value: glucose,
                    min: 50,
                    max: 300,
                    textColor: textColor,
                    accent: accent,
                    onChanged: (v) => setState(() => glucose = v),
                    isInteger: true,
                  ),
                  const SizedBox(height: 16),
                  _choiceSection(
                    label: '심장 질환',
                    value: heartDisease,
                    options: const ['없음', '있음'],
                    onChanged: (v) => setState(() => heartDisease = v),
                    textColor: textColor,
                    accent: accent,
                  ),
                  const SizedBox(height: 16),
                  _choiceSection(
                    label: '고혈압',
                    value: hypertension,
                    options: const ['없음', '있음'],
                    onChanged: (v) => setState(() => hypertension = v),
                    textColor: textColor,
                    accent: accent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: '생활 습관',
              cardColor: cardColor,
              borderColor: borderColor,
              titleColor: textColor,
              child: Column(
                children: [
                  _dropdownTile(
                    label: '직업 유형',
                    value: workType,
                    items: workTypes,
                    textColor: textColor,
                    onChanged: (v) => setState(() => workType = v!),
                  ),
                  const SizedBox(height: 16),
                  _dropdownTile(
                    label: '흡연 상태',
                    value: smokingStatus,
                    items: smokingOptions,
                    textColor: textColor,
                    onChanged: (v) => setState(() => smokingStatus = v!),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: predictStroke,
                icon: const Icon(Icons.analytics_outlined),
                label: const Text(
                  '뇌졸중 예측하기',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: Column(
                children: [
                  Icon(Icons.health_and_safety, color: accent, size: 36),
                  const SizedBox(height: 12),
                  Text(
                    resultText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _headerCard({
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '건강 상태를 입력해보세요',
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Text(
          //   '입력된 정보를 바탕으로 뇌졸중 위험도를 간단히 예측합니다.',
          //   style: TextStyle(
          //     color: subTextColor,
          //     fontSize: 15,
          //     height: 1.5,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
    required Color cardColor,
    required Color borderColor,
    required Color titleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _dateTile({
    required String label,
    required String value,
    required String subValue,
    required Color textColor,
    required Color subTextColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
          border: Border.all(color: subTextColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_month, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subValue,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderTile({
    required String label,
    required double value,
    required double min,
    required double max,
    required Color textColor,
    required Color accent,
    required ValueChanged<double> onChanged,
    bool isInteger = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              isInteger ? value.toInt().toString() : value.toStringAsFixed(1),
              style: TextStyle(
                color: accent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: accent,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _choiceSection({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
    required Color textColor,
    required Color accent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((item) {
            final selected = value == item;
            return ChoiceChip(
              label: Text(item),
              selected: selected,
              onSelected: (_) => onChanged(item),
              selectedColor: accent.withOpacity(0.18),
              labelStyle: TextStyle(
                color: selected ? accent : textColor,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide(
                color: selected ? accent : textColor.withOpacity(0.2),
              ),
              backgroundColor: Colors.transparent,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _dropdownTile({
    required String label,
    required String value,
    required List<String> items,
    required Color textColor,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}