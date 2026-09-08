import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/core/localizations/app_localizations.dart';

class InviteBannerWidget extends StatelessWidget {
  final VoidCallback onTap;

  const InviteBannerWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: AppColors.inviteBackground,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.invitePrimary,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inviteFriends,
                    style: const TextStyle(
                      color: AppColors.invitePrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.inviteSubtitle,
                    style: const TextStyle(
                      color: AppColors.inviteSubtitle,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
