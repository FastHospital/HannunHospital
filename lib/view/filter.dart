import 'package:flutter/material.dart';
import 'package:mytownmysymptom/service/disease_api.dart';
import '../widgets/dropdown_app_bar.dart';
import '../widgets/selected_bottom_sheet.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String filter = "전체보기"; //

  final api = DiseaseApi('http://10.0.2.2:8000');
  bool loading = false;
  List<Map<String, dynamic>> lastResult = [];

  final Map<String, String> symptomToFeature = const {
    "고열": "high_fever",
    "미열": "mild_fever",
    "오한": "chills",
    "가려움": "itching",
    "지속적재채기": "continuous_sneezing",
    "피부발진": "skin_rash",
    "기침": "cough",
    "가래": "phlegm",
    "침삼킬때가려움": "throat_irritation",
  };

  final List<String> menuItems = const [
    "전체보기",
    "발열 / 감염 관련",
    "호흡기 관련",
    "피부 관련",
    "통증 관련",
  ];

  final Map<String, List<String>> symptomsByFilter = const {
    "전체보기": [
      "고열",
      "미열",
      "오한",
      "가려움",
      "지속적\n재채기",
      "피부\n발진",
      "기침",
      "가래",
      "침삼킬때\n가려움",
      "기타",
    ],
    "발열 / 감염 관련": ["고열", "미열", "오한"],
    "호흡기 관련": ["지속적\n재채기", "기침", "가래", "침삼킬때\n가려움"],
    "피부 관련": ["가려움", "피부\n발진"],
    "통증 관련": ["기타"],
  };

  final Set<String> selected = <String>{};

  static const Color primaryBlue = Color(0xFF2F7DFF);
  static const Color skyText = Color(0xFF5DB6FF);
  static const Color chipGray = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    final borderGray = Colors.grey.shade300;

    final filteredSymptoms =
        symptomsByFilter[filter] ?? const <String>[];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DropdownAppBar(
        value: filter,
        items: menuItems,
        onChanged: (v) {
          setState(() {
            filter = v;
            selected.clear();
            lastResult = [];
            loading = false;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.25,
                    ),
                itemCount: filteredSymptoms.length,
                itemBuilder: (context, i) {
                  final label = filteredSymptoms[i];
                  final key = label.replaceAll("\n", "");
                  final isSelected = selected.contains(key);

                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selected.remove(key);
                        } else {
                          selected.add(key);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryBlue
                            : chipGray,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? primaryBlue
                              : borderGray,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : skyText,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            if (selected.isNotEmpty)
              SelectedSummaryBar(
                count: selected.length,
                onTap: _openSelectedBottomSheet,
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: selected.isEmpty || loading
                    ? null
                    : _onPredictPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  disabledBackgroundColor:
                      Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.black54,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "증상확인하기",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPredictPressed() async {
    setState(() => loading = true);

    try {
      final features = selected
          .map((k) => symptomToFeature[k.trim()])
          .whereType<String>()
          .toList();

      if (features.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("서버로 보낼 증상(feature) 매핑이 없어요."),
          ),
        );
        return;
      }

      final res = await api.predictTopK(
        symptoms: features,
        topK: 3,
      );
      if (!mounted) return;

      setState(() => lastResult = res);
      _showResultBottomSheet(res);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("예측 실패: $e")));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _showResultBottomSheet(
    List<Map<String, dynamic>> items,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "예측 결과 Top3",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                ...items.map((m) {
                  final disease = (m["disease"] ?? "")
                      .toString();
                  final prob =
                      (m["prob"] as num?)?.toDouble() ??
                      0.0;
                  final desc = (m["description"] ?? "")
                      .toString();
                  final precautions =
                      (m["precautions"] as List?)?.join(
                        ", ",
                      ) ??
                      "";

                  return ListTile(
                    title: Text(
                      "$disease  (${(prob * 100).toStringAsFixed(1)}%)",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      "${desc.isNotEmpty ? desc : "설명 없음"}\n"
                      "${precautions.isNotEmpty ? "주의: $precautions" : ""}",
                    ),
                    isThreeLine: true,
                  );
                }),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("닫기"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openSelectedBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final items = selected.toList()..sort();

            return SelectedBottomSheet(
              items: items,
              onRemove: (name) {
                setState(() => selected.remove(name));
                setModalState(() {});
              },
              onClear: () {
                setState(() => selected.clear());
                setModalState(() {});
                Navigator.pop(context); // 원하면 닫기 유지
              },
            );
          },
        );
      },
    );
  }
}
