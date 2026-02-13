import 'package:fluttapp/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int> cartIds;
  final Set<int> favoriteIds;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cartIds,
    required this.favoriteIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                final id = widget.product.id!;
                if (widget.favoriteIds.contains(id)) {
                  widget.favoriteIds.remove(id);
                } else {
                  widget.favoriteIds.add(id);
                }
              });
            },
            icon: Icon(
              widget.favoriteIds.contains(widget.product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red.shade400,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id!,
                child: Image.network(
                  widget.product.image ?? "",
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 2),

              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? "",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 2),
                    Text(
                      widget.product.tagline ?? "",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(widget.product.description ?? ""),

                    SizedBox(height: 10),
                    Text(
                      widget.product.price ?? "",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),

                    SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.cartIds.add(widget.product.id!);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added to cart"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green.shade600,
                            margin: EdgeInsets.only(
                              bottom: 70,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 45),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
