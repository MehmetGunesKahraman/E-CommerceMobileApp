import 'package:fluttapp/components/product_image.dart';
import 'package:fluttapp/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  final Set<int> favoriteIds;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.favoriteIds,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: product.id!,
                child: ProductImage(
                  image: product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onFavoriteToggle,
                    iconSize: 18,
                    icon: Icon(
                      favoriteIds.contains(product.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2),
          Text(
            product.name ?? "",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            product.tagline ?? "",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 2),
          Text(
            product.price ?? "",
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
