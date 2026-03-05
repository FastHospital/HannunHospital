import 'package:flutter/material.dart';

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

  void _toggle() => _entry != null ? _remove() : _show();

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
