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

  String gender = 'Male';
  String residenceType = 'Urban';
  int heartDisease = 1;
  int hypertension = 1;
  String everMarried = 'Yes';
  String workType = 'Private';
  String smokingStatus = 'smokes';

  String resultText = 'Potential Stroke';
  bool isDark = true;

  final List<String> workTypes = [
    'Private',
    'Self-employed',
    'Govt_job',
    'children',
    'Never_worked',
  ];

  final List<String> smokingOptions = [
    'never smoked',
    'formerly smoked',
    'smokes',
    'Unknown',
  ];

  Future<void> predictStroke() async {


    setState(() {
      resultText = 'Potential Stroke';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF111118) : Colors.white;
    final cardColor = isDark ? const Color(0xFF171720) : const Color(0xFFF5F5F7);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final accent = const Color(0xFFD8B8FF);
    final lineColor = isDark ? Colors.white12 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          'Stroke Prediction App',
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
              label: 'Age:',
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
              label: 'BMI:',
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
              label: 'Glucose Level:',
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
              label: 'Gender:',
              groupValue: gender,
              options: const ['Male', 'Female'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => gender = v!),
            ),
            _radioSection<String>(
              label: 'Residence Type',
              groupValue: residenceType,
              options: const ['Urban', 'Rural'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => residenceType = v!),
            ),
            _radioSection<int>(
              label: 'Heart Disease',
              groupValue: heartDisease,
              options: const [0, 1],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => heartDisease = v!),
            ),
            _radioSection<int>(
              label: 'Hypertension',
              groupValue: hypertension,
              options: const [0, 1],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => hypertension = v!),
            ),
            _radioSection<String>(
              label: 'Ever Married',
              groupValue: everMarried,
              options: const ['No', 'Yes'],
              textColor: textColor,
              dividerColor: lineColor,
              activeColor: accent,
              onChanged: (v) => setState(() => everMarried = v!),
            ),
            _dropdownSection(
              label: 'Work Type',
              value: workType,
              items: workTypes,
              textColor: textColor,
              dividerColor: lineColor,
              cardColor: cardColor,
              onChanged: (v) => setState(() => workType = v!),
            ),
            _dropdownSection(
              label: 'Smoking Status',
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
                    backgroundColor: isDark
                        ? const Color(0xFF1E1E29)
                        : const Color(0xFFE7E7EF),
                    foregroundColor: textColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Predict Stroke',
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
              'Result: $resultText',
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
                label,
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
                  inactiveTrackColor: Colors.white24,
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
                          return Colors.white70;
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