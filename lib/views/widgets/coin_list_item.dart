import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/utils/formatter.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';
import 'package:mobile_assignment_coin/views/widgets/change_badge_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/coin_icon_widget.dart';

class CoinListItem extends StatelessWidget {
  final CoinsModel coin;
  final VoidCallback onTap;

  const CoinListItem({
    super.key,
    required this.coin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.divider, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            CoinIconWidget(url: coin.iconUrl, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.symbol ?? '',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppFormatters.formatMarketCap(
                      num.tryParse(coin.marketCap ?? '0'),
                    ),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppFormatters.formatPrice(num.tryParse(coin.price ?? '0')),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            ChangeBadgeWidget(change: coin.change),
          ],
        ),
      ),
    );
  }
}
