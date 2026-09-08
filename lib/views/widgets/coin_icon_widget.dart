import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinIconWidget extends StatelessWidget {
  final String? url;
  final double size;

  const CoinIconWidget({
    super.key,
    required this.url,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
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
