import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(product.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('\$${product.price}', style: TextStyle(color: Colors.teal, fontSize: 18)),
                  SizedBox(height: 10),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.star, size: 20, color: Colors.yellow),
                      Text('${product.rating} Ratings'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
