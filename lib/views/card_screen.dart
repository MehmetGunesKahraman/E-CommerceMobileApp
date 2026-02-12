import 'package:fluttapp/models/product_model.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cartIds;

  const CardScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => widget.cartIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            cartProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your cart is empty",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final item = cartProducts[index];

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(12),
                                child: Image.network(
                                  item.image!,
                                  width: 70,
                                  height: 70,
                                ),
                              ),

                              SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(item.tagline!),
                                    Text(
                                      item.price!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.cartIds.remove(item.id);
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline_outlined,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Checkout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
