import 'package:flutter/material.dart';

class SelectedSummaryBar extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const SelectedSummaryBar({
    super.key,
    required this.count,
    required this.onTap,
  });

  static const Color primaryBlue = Color(0xFF2F7DFF);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Text(
              "현재 증상",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 6),
            Text(
              "$count가지",
              style: const TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_up,
              size: 20,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedBottomSheet extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onRemove;
  final VoidCallback onClear;

  const SelectedBottomSheet({
    super.key,
    required this.items,
    required this.onRemove,
    required this.onClear,
  });

  static const Color primaryBlue = Color(0xFF2F7DFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, -6),
              color: Colors.black.withOpacity(0.12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "현재 나의 증상은",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    onClear(); // 부모 selected.clear() 실행
                    Navigator.pop(
                      context,
                    ); // 바텀시트 닫기 (가장 확실)
                  },
                  child: const Text("전체삭제"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items
                  .map(
                    (e) => _ChipPill(
                      text: e,
                      onRemove: () => onRemove(e),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "증상선택하기",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipPill extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;

  const _ChipPill({
    required this.text,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(999),
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
