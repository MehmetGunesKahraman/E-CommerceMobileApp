import 'package:fluttapp/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Data product;
  const ProductCard({super.key, required this.product});

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
          Hero(
            tag: product.id!,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.image ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
