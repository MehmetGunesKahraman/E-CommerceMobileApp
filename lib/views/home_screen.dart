import 'package:fluttapp/components/product_card.dart';
import 'package:fluttapp/models/product_model.dart';
import 'package:fluttapp/services/api_service.dart';
import 'package:fluttapp/views/card_screen.dart';
import 'package:fluttapp/views/favorites_screen.dart';
import 'package:fluttapp/views/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  ApiService apiService = ApiService();
  bool isLoading = false;
  String errorMassage = "";
  List<Data> allProducts = [];
  Set<int> cartIds = {};
  Set<int> favoriteIds = {};
  String _sortOption = "None";

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
      });
      ProductsModel data = await apiService.fetchProducts();

      setState(() {
        allProducts = data.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMassage = "Failed to load products. ${e.toString()}";
        allProducts = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  List<Data> _getSortedProducts() {
    final displayProducts = List<Data>.from(allProducts);

    if (_sortOption == "Price: Low to High") {
      displayProducts.sort((a, b) {
        final priceA = double.tryParse(a.price ?? "0") ?? 0;
        final priceB = double.tryParse(b.price ?? "0") ?? 0;
        return priceA.compareTo(priceB);
      });
    } else if (_sortOption == "Price: High to Low") {
      displayProducts.sort((a, b) {
        final priceA = double.tryParse(a.price ?? "0") ?? 0;
        final priceB = double.tryParse(b.price ?? "0") ?? 0;
        return priceB.compareTo(priceA);
      });
    }

    return displayProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesScreen(
                                products: allProducts,
                                favoriteIds: favoriteIds,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                        iconSize: 30,
                        icon: Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardScreen(
                                products: allProducts,
                                cartIds: cartIds,
                              ),
                            ),
                          );
                        },
                        iconSize: 32,
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Find your perfect device",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              SizedBox(height: 12),
              DropdownButton<String>(
                value: _sortOption,
                isExpanded: false,
                items: const [
                  DropdownMenuItem(value: "None", child: Text("Sort by")),
                  DropdownMenuItem(
                    value: "Price: Low to High",
                    child: Text("Price: Low to High"),
                  ),
                  DropdownMenuItem(
                    value: "Price: High to Low",
                    child: Text("Price: High to Low"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _sortOption = value;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://wantapi.com/assets/banner.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              SizedBox(height: 16),
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMassage != "")
                Center(child: Text(errorMassage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: _getSortedProducts().length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = _getSortedProducts()[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                cartIds: cartIds,
                                favoriteIds: favoriteIds,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          product: product,
                          favoriteIds: favoriteIds,
                          onFavoriteToggle: () {
                            setState(() {
                              final id = product.id!;
                              if (favoriteIds.contains(id)) {
                                favoriteIds.remove(id);
                              } else {
                                favoriteIds.add(id);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
