import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/utils/formatter.dart';

class ChangeBadgeWidget extends StatelessWidget {
  final String? change;

  const ChangeBadgeWidget({
    super.key,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    final changeNum = num.tryParse(change ?? '0') ?? 0;
    final isPositive = changeNum >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive ? AppColors.priceUp : AppColors.priceDown,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        AppFormatters.formatChange(changeNum),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
