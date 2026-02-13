import 'dart:convert';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ProductImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final content = _buildImage();

    if (borderRadius == null) {
      return content;
    }

    return ClipRRect(borderRadius: borderRadius!, child: content);
  }

  Widget _buildImage() {
    final source = image?.trim() ?? "";

    if (source.isEmpty) {
      return _placeholder();
    }

    if (source.startsWith("data:image")) {
      final base64Data = source.split(',').last;
      final bytes = base64Decode(base64Data);
      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    if (source.startsWith("assets/")) {
      return Image.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return Image.network(
      source,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, color: Colors.grey.shade500, size: 36),
    );
  }
}
