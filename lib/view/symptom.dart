import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SymptomScreen(),
    );
  }
}

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});
  @override
  State<SymptomScreen> createState() =>
      _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  String filter = "전체보기";
  final List<String> menuItems = const [
    "전체보기",
    "발열 / 감염 관련",
    "호흡기 관련",
    "피부 관련",
    "통증 관련",
  ];

  final List<String> symptoms = const [
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
  ];

  final Set<String> selected = {"미열", "오한"};

  static const Color primaryBlue = Color(0xFF2F7DFF);
  static const Color skyText = Color(0xFF5DB6FF);
  static const Color chipGray = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    final borderGray = Colors.grey.shade300;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DropdownAppBar(
        value: filter,
        items: menuItems,
        onChanged: (v) => setState(() => filter = v),
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
                itemCount: symptoms.length,
                itemBuilder: (context, i) {
                  final label = symptoms[i];
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
            SizedBox(height: 10),
            if (selected.isNotEmpty)
              _SelectedSummaryBar(
                count: selected.length,
                onTap: _openSelectedBottomSheet,
              ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: selected.isEmpty ? null : () {},
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
                child: Text(
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

  void _openSelectedBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        final items = selected.toList()..sort();
        return _SelectedBottomSheet(
          items: items,
          onRemove: (name) =>
              setState(() => selected.remove(name)),
          onClear: () => setState(() => selected.clear()),
        );
      },
    );
  }
}

class _SelectedSummaryBar extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _SelectedSummaryBar({
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
            Text(
              "현재 증상",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 6),
            Text(
              "$count가지",
              style: const TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Icon(
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

class _SelectedBottomSheet extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onRemove;
  final VoidCallback onClear;

  const _SelectedBottomSheet({
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
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "현재 나의 증상은",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onClear,
                  child: Text("전체삭제"),
                ),
              ],
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 14),
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
                child: Text(
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
          SizedBox(width: 6),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(999),
            child: Icon(
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

class DropdownAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const DropdownAppBar({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  State<DropdownAppBar> createState() =>
      _DropdownAppBarState();
}

class _DropdownAppBarState extends State<DropdownAppBar> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _remove() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() {});
  }

  void _toggle() {
    if (_entry != null) {
      _remove();
    } else {
      _show();
    }
  }

  void _show() {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final size = box.size;

    _entry = OverlayEntry(
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _remove,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: CompositedTransformFollower(
                link: _link,
                showWhenUnlinked: false,
                offset: Offset(0, size.height),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                          color: Colors.black.withOpacity(
                            0.10,
                          ),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          8,
                          16,
                          12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            widget.items.length,
                            (i) {
                              final e = widget.items[i];
                              final selected =
                                  e == widget.value;

                              return InkWell(
                                onTap: () {
                                  widget.onChanged(e);
                                  _remove();
                                },
                                borderRadius:
                                    BorderRadius.circular(
                                      12,
                                    ),
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? const Color(
                                            0xFFF3F8FF,
                                          )
                                        : Colors
                                              .transparent,
                                    borderRadius:
                                        BorderRadius.circular(
                                          12,
                                        ),
                                  ),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: selected
                                          ? FontWeight.w900
                                          : FontWeight.w700,
                                      color: selected
                                          ? const Color(
                                              0xFF2F7DFF,
                                            )
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_entry!);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = _entry != null;

    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: CompositedTransformTarget(
          link: _link,
          child: InkWell(
            onTap: _toggle,
            child: Container(
              height: widget.preferredSize.height,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
