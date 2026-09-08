import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/utils/formatter.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';
import 'package:mobile_assignment_coin/views/widgets/change_badge_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/coin_icon_widget.dart';

class Top3CoinsWidget extends StatelessWidget {
  final List<CoinsModel> topCoins;
  final ValueChanged<CoinsModel> onCoinTapped;

  const Top3CoinsWidget({
    super.key,
    required this.topCoins,
    required this.onCoinTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: topCoins.map((coin) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onCoinTapped(coin),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CoinIconWidget(url: coin.iconUrl, size: 42),
                  const SizedBox(height: 10),
                  Text(
                    coin.symbol ?? '',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.formatPrice(num.tryParse(coin.price ?? '0')),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ChangeBadgeWidget(change: coin.change),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
