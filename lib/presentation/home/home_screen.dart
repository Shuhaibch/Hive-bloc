import 'package:datacube/application/cart/cart_bloc.dart';
import 'package:datacube/application/products/product_bloc.dart';
import 'package:datacube/domain/cart/cart_model.dart';
import 'package:datacube/domain/products/products_model.dart';
import 'package:datacube/presentation/cart/cart_screen.dart';
import 'package:datacube/presentation/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ));
              },
              icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is FetchProductSuccess) {
              return GridView.builder(
                itemCount: state.product.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final Product product = state.product.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DetailScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2)),
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .29,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .11,
                                width: MediaQuery.of(context).size.width * .6,
                                child: Image.network(product.thumbnail),
                              ),
                              Text(product.title),
                              Text(product.price.toString()),
                              Text(product.category),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final Cart prod = Cart(
                                          name: product.title,
                                          image: product.thumbnail,
                                          count: 1,
                                          id: product.id);
                                      context
                                          .read<CartBloc>()
                                          .add(AddProduct(product: prod));
                                    },
                                    child: const Icon(
                                      Icons.shopping_bag_rounded,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FetchProductFailed) {
              return const Center(
                child: Text("Failed"),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
