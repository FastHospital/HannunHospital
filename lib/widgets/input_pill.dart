import 'package:flutter/material.dart';
import 'package:mytownmysymptom/theme/app_color.dart';

class InputPill extends StatelessWidget {
  final String hintText;
  final VoidCallback onMicTap;
  final VoidCallback onSendTap;

  const InputPill({
    super.key,
    required this.hintText,
    required this.onMicTap,
    required this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
              decoration: const BoxDecoration(
                color: AppColors.blue,
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
