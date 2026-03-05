import 'package:flutter/material.dart';
import 'package:mytownmysymptom/theme/app_color.dart';

class ActionTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ActionTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 92,
      child: Material(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
