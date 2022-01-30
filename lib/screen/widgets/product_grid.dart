import 'package:flutter/material.dart';
import 'package:foody/common/request_state.dart';
import 'package:foody/provider/product_provider.dart';
import 'package:foody/screen/detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, _) {
        if (value.requestState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.requestState == RequestState.noData) {
          return const Center(
            child: Text('Failed get data'),
          );
        } else if (value.requestState == RequestState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
                ElevatedButton(
                  onPressed: () {
                    value.fetchAllProducts();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        } else if (value.requestState == RequestState.hasData) {
          final productList = value.allProduct;
          return SmartRefresher(
            controller: value.controller,
            onRefresh: () => value.pullRefresh(),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments: productList[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: productList[index].cover,
                              child: Container(
                                width: 200,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(productList[index].cover),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            productList[index].name,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            productList[index].price.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
