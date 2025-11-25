// lib/widgets/cached_image.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String url; final double? height; final double? width;
  const CachedImage({required this.url, this.height, this.width, super.key});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height, width: width, fit: BoxFit.cover,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100,
        child: Container(color: Colors.white, height: height, width: width),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported),
    );
  }
}
