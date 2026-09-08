import 'package:intl/intl.dart';

class AppFormatters {
  static String formatMarketCap(num? marketCap) {
    if (marketCap == null || marketCap <= 0) return '\$0.00';
    if (marketCap >= 1e12) {
      return '\$${(marketCap / 1e12).toStringAsFixed(2)} trillion';
    } else if (marketCap >= 1e9) {
      return '\$${(marketCap / 1e9).toStringAsFixed(2)} billion';
    } else if (marketCap >= 1e6) {
      return '\$${(marketCap / 1e6).toStringAsFixed(2)} million';
    } else if (marketCap >= 1e3) {
      return '\$${(marketCap / 1e3).toStringAsFixed(2)} thousand';
    }
    return '\$${marketCap.toStringAsFixed(2)}';
  }

  static String formatPrice(num? price) {
    if (price == null) return '\$0.00';
    if (price >= 1) {
      final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
      return formatter.format(price);
    } else {
      return '\$${price.toStringAsFixed(2)}';
    }
  }

  static String formatChange(num? change) {
    if (change == null) return '0.00%';
    final formatted = change.abs().toStringAsFixed(2);
    return change >= 0 ? '+$formatted%' : '-$formatted%';
  }

  static String sanitizeDescription(String? htmlContent) {
    if (htmlContent == null || htmlContent.trim().isEmpty) return '';
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlContent.replaceAll(exp, '').replaceAll('&amp;', '&').trim();
  }
}
