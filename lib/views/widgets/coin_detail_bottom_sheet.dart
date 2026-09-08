import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/localizations/app_localizations.dart';
import 'package:mobile_assignment_coin/core/utils/formatter.dart';
import 'package:mobile_assignment_coin/models/coin_detail_response.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';
import 'package:mobile_assignment_coin/services/coin_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinDetailBottomSheet extends StatefulWidget {
  final CoinsModel coin;

  const CoinDetailBottomSheet({super.key, required this.coin});

  static Future<void> show(BuildContext context, CoinsModel coin) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CoinDetailBottomSheet(coin: coin),
    );
  }

  @override
  State<CoinDetailBottomSheet> createState() => _CoinDetailBottomSheetState();
}

class _CoinDetailBottomSheetState extends State<CoinDetailBottomSheet> {
  late Future<CoinDetailResponseModel> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = CoinService.execute(context: context)
        .getCoinsDetail(uuid: widget.coin.uuid ?? '');
  }

  Color _parseColor(String? hexString) {
    if (hexString == null || hexString.isEmpty) return AppColors.textPrimary;
    try {
      String formatted = hexString.replaceAll('#', '').trim();
      if (formatted.length == 6) {
        formatted = 'FF$formatted';
      } else if (formatted.length == 3) {
        formatted = 'FF${formatted.split('').map((c) => '$c$c').join()}';
      }
      return Color(int.parse(formatted, radix: 16));
    } catch (_) {
      return AppColors.textPrimary;
    }
  }

  Future<void> _openWebsite(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    final nameColor = _parseColor(coin.color);
    final changeNum = num.tryParse(coin.change ?? '0') ?? 0;
    final isPositive = changeNum >= 0;
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF6B7280),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCoinIcon(coin.iconUrl, size: 54),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            coin.name ?? '',
                            style: TextStyle(
                              color: nameColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${coin.symbol ?? ''})',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: l10n.priceLabel,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: AppFormatters.formatPrice(
                              num.tryParse(coin.price ?? '0'),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: l10n.marketCapLabel,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: AppFormatters.formatMarketCap(
                              num.tryParse(coin.marketCap ?? '0'),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isPositive ? AppColors.priceUp : AppColors.priceDown,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${changeNum.abs().toStringAsFixed(2)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<CoinDetailResponseModel>(
            future: _detailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  ),
                );
              }

              final detail = snapshot.data?.data?.coin;
              final rawDesc = detail?.description;
              final sanitizedDesc = AppFormatters.sanitizeDescription(rawDesc);
              final hasDescription = sanitizedDesc.isNotEmpty;
              final websiteUrl = detail?.websiteUrl;
              final hasWebsite =
                  websiteUrl != null && websiteUrl.trim().isNotEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasDescription ? sanitizedDesc : l10n.noDescription,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: hasDescription
                          ? AppColors.textBody
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (hasWebsite) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _openWebsite(websiteUrl),
                      child: Text(
                        l10n.readMore,
                        style: const TextStyle(
                          color: AppColors.linkBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCoinIcon(String? url, {double size = 54}) {
    final isSvg = (url ?? '').toLowerCase().endsWith('.svg');
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: isSvg
            ? SvgPicture.network(
                url ?? '',
                width: size,
                height: size,
                fit: BoxFit.contain,
                placeholderBuilder: (_) => _placeholder(size),
              )
            : Image.network(
                url ?? '',
                width: size,
                height: size,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => _placeholder(size),
              ),
      ),
    );
  }

  Widget _placeholder(double size) {
    return Container(
      width: size,
      height: size,
      color: const Color(0xFFEFEFF1),
      child: Icon(
        Icons.monetization_on_outlined,
        size: size * 0.6,
        color: Colors.grey,
      ),
    );
  }
}
