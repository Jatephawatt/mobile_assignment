import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Coin Ranking App',
      'search_placeholder': 'Search',
      'no_coins_found': 'No coins found',
      'no_results_found': 'No results found',
      'no_results_desc': 'We couldn\'t find any coin matching "{keyword}".',
      'failed_to_load_coins': 'Failed to load coins',
      'something_went_wrong':
          'Something went wrong. Please check your connection and try again.',
      'loading_coins': 'Loading coins...',
      'loading_more_coins': 'Loading more coins...',
      'failed_to_load_more': 'Failed to load more coins',
      'retry': 'Retry',
      'try_again': 'Try again',
      'invite_friends': 'Invite Friends',
      'invite_subtitle': 'Get bonus coins for each friend!',
      'read_more': 'Read more',
      'no_description': 'No description',
      'price_label': 'Price: ',
      'market_cap_label': 'Market Cap: ',
    },
  };

  String get appTitle =>
      _localizedValues[locale.languageCode]?['app_title'] ?? 'Coin Ranking App';
  String get searchPlaceholder =>
      _localizedValues[locale.languageCode]?['search_placeholder'] ?? 'Search';
  String get noCoinsFound =>
      _localizedValues[locale.languageCode]?['no_coins_found'] ??
      'No coins found';
  String get noResultsFound =>
      _localizedValues[locale.languageCode]?['no_results_found'] ??
      'No results found';
  String noResultsDesc(String keyword) {
    final template =
        _localizedValues[locale.languageCode]?['no_results_desc'] ??
        'We couldn\'t find any coin matching "{keyword}".';
    return template.replaceAll('{keyword}', keyword);
  }

  String get failedToLoadCoins =>
      _localizedValues[locale.languageCode]?['failed_to_load_coins'] ??
      'Failed to load coins';
  String get somethingWentWrong =>
      _localizedValues[locale.languageCode]?['something_went_wrong'] ??
      'Something went wrong. Please check your connection and try again.';
  String get loadingCoins =>
      _localizedValues[locale.languageCode]?['loading_coins'] ??
      'Loading coins...';
  String get loadingMoreCoins =>
      _localizedValues[locale.languageCode]?['loading_more_coins'] ??
      'Loading more coins...';
  String get failedToLoadMore =>
      _localizedValues[locale.languageCode]?['failed_to_load_more'] ??
      'Failed to load more coins';
  String get retry =>
      _localizedValues[locale.languageCode]?['retry'] ?? 'Retry';
  String get tryAgain =>
      _localizedValues[locale.languageCode]?['try_again'] ?? 'Try again';
  String get inviteFriends =>
      _localizedValues[locale.languageCode]?['invite_friends'] ??
      'Invite Friends';
  String get inviteSubtitle =>
      _localizedValues[locale.languageCode]?['invite_subtitle'] ??
      'Get bonus coins for each friend!';
  String get readMore =>
      _localizedValues[locale.languageCode]?['read_more'] ?? 'Read more';
  String get noDescription =>
      _localizedValues[locale.languageCode]?['no_description'] ??
      'No description';
  String get priceLabel =>
      _localizedValues[locale.languageCode]?['price_label'] ?? 'Price: ';
  String get marketCapLabel =>
      _localizedValues[locale.languageCode]?['market_cap_label'] ??
      'Market Cap: ';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
