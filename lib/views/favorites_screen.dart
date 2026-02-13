import 'package:fluttapp/components/product_card.dart';
import 'package:fluttapp/models/product_model.dart';
import 'package:fluttapp/views/product_detail_screen.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> favoriteIds;
  final Set<int> cartIds;

  const FavoritesScreen({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.cartIds,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProducts = widget.products
        .where((product) => widget.favoriteIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favorites", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: favoriteProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 6),
                    Text(
                      "No favorites yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: favoriteProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              cartIds: widget.cartIds,
                              favoriteIds: widget.favoriteIds,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          ProductCard(
                            product: product,
                            favoriteIds: widget.favoriteIds,
                            onFavoriteToggle: () {
                              setState(() {
                                final id = product.id!;
                                if (widget.favoriteIds.contains(id)) {
                                  widget.favoriteIds.remove(id);
                                } else {
                                  widget.favoriteIds.add(id);
                                }
                              });
                            },
                          ),
                          Positioned(
                            right: 0,
                            top: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.favoriteIds.remove(product.id);
                                  });
                                },
                                iconSize: 18,
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
