import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedNetworkImage extends StatelessWidget {
  const RoundedNetworkImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 10.0,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
        ),
      );
}
