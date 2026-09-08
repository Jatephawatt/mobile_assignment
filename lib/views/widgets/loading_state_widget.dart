import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/localizations/app_localizations.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.textSecondary),
            const SizedBox(height: 12),
            Text(
              l10n.loadingCoins,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
