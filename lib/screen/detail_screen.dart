import 'package:flutter/material.dart';
import 'package:foody/model/product_model.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final ProductModel product;

  DetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Hero(
                  tag: product.cover,
                  child: Image.network(
                    product.cover,
                    width: 450,
                    height: 300,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Price: ${product.price}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    product.desc,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const Divider(color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
